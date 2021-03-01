import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tada_client/helpers/regex_helper.dart';
import 'package:tada_client/models/domain/Message.dart';
import 'package:tada_client/models/error_model.dart';
import 'package:tada_client/service/business_logic/messaing_service.dart';
import 'package:tada_client/service/common/connectivity/connectivity_service.dart';
import 'package:tada_client/service/common/log/error_service.dart';
import 'package:tada_client/service/common/storage/storage_service.dart';
import 'package:tada_client/service/ws/messaging/dto/SendMessageRequest.dart';
import 'package:tada_client/service/ws/ws_service.dart';

part 'room_event.dart';

part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc(RoomState initialState) : super(initialState);

  final MessagingService _messaging = Get.find();
  final ErrorService _error = Get.find();
  final WSService _ws = Get.find();
  final StorageService _storage = Get.find();
  final ConnectivityService _connect = Get.find();

  bool needUpdate = false;
  bool blockUpdate = false;

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    if (event is InitRoom) {
      yield* _mapInitRoomToState(event, state);
    } else if (event is SendMessage) {
      yield* _mapSendMessageToState(event, state);
    } else if (event is MessageAdded) {
      yield _mapMessageAddedToState(event, state);
    } else if (event is CommentChanged) {
      yield state.copyWith(comment: event.value);
    }
  }

  Stream<RoomState> _mapInitRoomToState(
    InitRoom event,
    RoomState state,
  ) async* {
    if (blockUpdate) return;
    blockUpdate = true;
    Timer(Duration(seconds: 1), () async {
      blockUpdate = false;
    });

    _connect.connectionStatus.listen((value) {
      if (value && needUpdate) {
        needUpdate = false;
        add(InitRoom(event.roomId));
      } else if (!value) {
        needUpdate = true;
      }
    });

    try {
      final messages = await _messaging.getRoomMessages(event.roomId);

      yield state.copyWith(
          messages: messages, roomId: event.roomId, version: state.version + 1);

      _ws.messageListener.listen((value) {
        if (value.room == event.roomId && value.id == null)
          add(MessageAdded(message: value));
      });
    } on DioError catch (e) {
      if (!(e.error is String) && e.error.osError.errorCode == 7) {
        _error.addError(ErrorModel(message: 'Отсутствует подключение'));
      } else {
        _error.addError(ErrorModel(message: 'Ошибка при получении данных'));
        add(InitRoom(event.roomId));
      }
    } catch (e) {
      _error.addError(ErrorModel(message: 'Системная ошибка'));
      add(InitRoom(event.roomId));
    }
  }

  Stream<RoomState> _mapSendMessageToState(
    SendMessage event,
    RoomState state,
  ) async* {
    final message = RegexHelper.removeUnneededSpaces(state.comment);
    if (message.length == 0) {
      _error.addError(ErrorModel(message: 'Вы не ввели ни одного символа!'));
      return;
    } else if (message.length > _storage.userSettings.maxMessageLength) {
      _error
          .addError(ErrorModel(message: 'Слишком длинный текст для отправки'));
      return;
    }

    if (_connect.isConnectedToInternet) {
      _ws.sendMessage(SendMessageRequest(
        text: message,
        room: state.roomId,
      ));
      state.textController.clear();
    } else
      _error.addError(ErrorModel(message: 'Отсутствует подключение'));
  }

  RoomState _mapMessageAddedToState(
    MessageAdded event,
    RoomState state,
  ) {
    state.messages.add(event.message);

    return state.copyWith(messages: state.messages, version: state.version + 1);
  }
}
