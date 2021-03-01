import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tada_client/helpers/regex_helper.dart';
import 'package:tada_client/models/domain/Message.dart';
import 'package:tada_client/models/domain/Room.dart';
import 'package:tada_client/models/error_model.dart';
import 'package:tada_client/service/business_logic/messaing_service.dart';
import 'package:tada_client/service/common/connectivity/connectivity_service.dart';
import 'package:tada_client/service/common/log/error_service.dart';
import 'package:tada_client/service/common/storage/storage_service.dart';
import 'package:tada_client/service/ws/messaging/dto/SendMessageRequest.dart';
import 'package:tada_client/service/ws/ws_service.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(MainState initialState) : super(initialState);

  final StorageService _storage = Get.find();
  final MessagingService _messaging = Get.find();
  final WSService _ws = Get.find();
  final ErrorService _error = Get.find();
  final ConnectivityService _connect = Get.find();

  final _androidAppRetain = MethodChannel('android_app_retain');

  bool needUpdate = false;

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is InitAuth) {
      yield* _mapInitAuthToState(event, state);
    } else if (event is InitRooms) {
      yield* _mapInitRoomsToState(event, state);
    } else if (event is CreateRoom) {
      yield* _mapCreateRoomToState(event, state);
    } else if (event is Logout) {
      yield _mapLogoutToState(event, state);
    } else if (event is LoginSuccess) {
      yield state.copyWith(isLoggedIn: true);
    } else if (event is MessageAdded) {
      yield _mapMessageAddedToState(event, state);
    } else if (event is OpenRoom) {
      yield _mapOpenRoomToState(event, state);
    } else if (event is ClosePage) {
      yield _mapClosePageToState(event, state);
    } else if (event is RoomNameChanged) {
      yield state.copyWith(
        roomId: state.roomId,
        roomName: event.value,
      );
    } else if (event is FirstMessageChanged) {
      yield state.copyWith(
        roomId: state.roomId,
        firstMessage: event.value,
      );
    } else if (event is ClearFields) {
      yield state.copyWith(
        roomId: state.roomId,
        firstMessage: '',
        roomName: '',
        firstMessageController: TextEditingController(),
        roomNameController: TextEditingController(),
      );
    }
  }

  Stream<MainState> _mapInitAuthToState(
    InitAuth event,
    MainState state,
  ) async* {
    final loggedIn = _storage.userSettings.isLoggedIn();
    if (loggedIn) _ws.init();

    add(InitRooms());
    yield state.copyWith(
      isLoggedIn: loggedIn,
    );
  }

  Stream<MainState> _mapInitRoomsToState(
    InitRooms event,
    MainState state,
  ) async* {
    _connect.connectionStatus.listen((value) {
      if (value && needUpdate) {
        needUpdate = false;
        add(InitRooms());
      } else if (!value) {
        needUpdate = true;
      }
    });

    try {
      final rooms = await _messaging.getRooms();

      rooms.sort(((first, second) =>
          second.lastMessage.created.compareTo(first.lastMessage.created)));

      if (state.messagesSubscription == null)
        state.messagesSubscription = _ws.messageListener?.listen((value) {
          print(value.text);
          add(MessageAdded(message: value));
        });

      yield state.copyWith(
        rooms: rooms,
        roomId: state.roomId,
        isLoggedIn: _storage.userSettings.isLoggedIn(),
        messagesSubscription: state.messagesSubscription,
        version: state.version + 1,
      );
    } on DioError catch (e) {
      if (!(e.error is String) && e.error.osError.errorCode == 7) {
        _error.addError(ErrorModel(message: 'Отсутствует подключение'));
      } else
        _error.addError(ErrorModel(message: 'Ошибка при получении данных'));
    } catch (e) {
      _error.addError(ErrorModel(message: 'Системная ошибка'));
    }
  }

  Stream<MainState> _mapCreateRoomToState(
    CreateRoom event,
    MainState state,
  ) async* {
    final chatName = RegexHelper.removeUnneededSpaces(state.roomName);

    final firstMessage = RegexHelper.removeUnneededSpaces(state.firstMessage);

    if (chatName.length == 0) {
      _error.addError(ErrorModel(message: 'Вы не заполнили название комнаты'));
      return;
    } else if (firstMessage.length == 0) {
      _error.addError(ErrorModel(message: 'Вы не заполнили первое сообщение'));
      return;
    } else if (chatName.length > _storage.userSettings.maxRoomTitleLength) {
      _error.addError(ErrorModel(message: 'Слишком длинное название комнаты'));
      return;
    } else if (firstMessage.length > _storage.userSettings.maxMessageLength) {
      _error
          .addError(ErrorModel(message: 'Слишком длинный текст для отправки'));
      return;
    }
    if (_connect.isConnectedToInternet) {
      var roomOpened = false;
      final temporaryListener = _ws?.messageListener?.listen((value) {
        if (value.id == chatName) {
          add(OpenRoom(roomId: chatName));
          roomOpened = true;
        }
      });

      _ws.sendMessage(SendMessageRequest(
        room: chatName,
        text: firstMessage,
        id: chatName,
      ));

      Timer.periodic(Duration(seconds: 1), (timer) {
        if (roomOpened) {
          temporaryListener?.cancel();
          timer?.cancel();
          add(ClearFields());
          add(InitRooms());
        }
      });
    } else
      _error.addError(ErrorModel(message: 'Отсутствует подключение'));
  }

  MainState _mapLogoutToState(
    Logout event,
    MainState state,
  ) {
    _storage.userSettings.clearData();
    return state.copyWith(isLoggedIn: false);
  }

  MainState _mapClosePageToState(
    ClosePage event,
    MainState state,
  ) {
    if (state.roomId != null)
      return state.copyWith(roomId: null);
    else {
      if (Platform.isAndroid)
        _androidAppRetain.invokeMethod('sendToBackground');
      return state;
    }
  }

  MainState _mapMessageAddedToState(
    MessageAdded event,
    MainState state,
  ) {
    state.rooms
        .firstWhere((element) => element.name == event.message.room,
            orElse: () => null)
        ?.lastMessage = event.message;
    state.rooms.sort(((first, second) =>
        second.lastMessage.created.compareTo(first.lastMessage.created)));
    return state.copyWith(
        rooms: state.rooms, roomId: state.roomId, version: state.version + 1);
  }

  MainState _mapOpenRoomToState(
    OpenRoom event,
    MainState state,
  ) {
    if (!_connect.isConnectedToInternet) {
      _error.addError(ErrorModel(message: 'Отсутствует подключение'));
      return state;
    }
    return state.copyWith(roomId: event.roomId);
  }
}
