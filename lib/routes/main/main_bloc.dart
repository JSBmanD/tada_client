import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tada_client/models/domain/Message.dart';
import 'package:tada_client/models/domain/Room.dart';
import 'package:tada_client/service/business_logic/messaing_service.dart';
import 'package:tada_client/service/common/storage/storage_service.dart';
import 'package:tada_client/service/ws/ws_service.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(MainState initialState) : super(initialState);

  final StorageService _storage = Get.find();
  final MessagingService _messaging = Get.find();
  final WSService _ws = Get.find();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is InitRooms) {
      yield* _mapInitRoomsToState(event, state);
    } else if (event is Logout) {
      yield _mapLogoutToState(event, state);
    } else if (event is LoginSuccess) {
      yield state.copyWith(isLoggedIn: true);
    } else if (event is MessageAdded) {
      yield _mapMessageAddedToState(event, state);
    }
  }

  Stream<MainState> _mapInitRoomsToState(
    InitRooms event,
    MainState state,
  ) async* {
    yield state.copyWith(isLoggedIn: _storage.userSettings.isLoggedIn());

    final rooms = await _messaging.getRooms();
    rooms.sort(((first, second) =>
        second.lastMessage.created.compareTo(first.lastMessage.created)));

    yield state.copyWith(rooms: rooms, version: state.version + 1);

    _ws.messageListener
        .listen((value) {
          print(value.text);
          add(MessageAdded(message: value));
        })
        .asFuture()
        .then((value) {});
  }

  MainState _mapLogoutToState(
    Logout event,
    MainState state,
  ) {
    _storage.userSettings.clearData();
    return state.copyWith(isLoggedIn: false);
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
    return state.copyWith(rooms: state.rooms, version: state.version + 1);
  }
}
