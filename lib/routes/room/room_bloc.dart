import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tada_client/models/domain/Message.dart';
import 'package:tada_client/models/error_model.dart';
import 'package:tada_client/service/business_logic/messaing_service.dart';
import 'package:tada_client/service/common/log/error_service.dart';
import 'package:tada_client/service/ws/messaging/dto/SendMessageRequest.dart';
import 'package:tada_client/service/ws/ws_service.dart';

part 'room_event.dart';

part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc(RoomState initialState) : super(initialState);

  final MessagingService _messaging = Get.find();
  final ErrorService _error = Get.find();
  final WSService _ws = Get.find();

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    if (event is InitRoom) {
      yield* _mapInitRoomToState(event, state);
    } else if (event is InputChanged) {
      yield _mapInputChangedToState(event, state);
    } else if (event is SendMessage) {
      yield* _mapSendMessageToState(event, state);
    } else if (event is MessageAdded) {
      yield _mapMessageAddedToState(event, state);
    }
  }

  Stream<RoomState> _mapInitRoomToState(
    InitRoom event,
    RoomState state,
  ) async* {
    final messages = await _messaging.getRoomMessages(event.roomId);

    yield state.copyWith(
        messages: messages, roomId: event.roomId, version: state.version + 1);

    _ws.messageListener.listen((value) {
      if (value.room == event.roomId) add(MessageAdded(message: value));
    });
  }

  Stream<RoomState> _mapSendMessageToState(
    SendMessage event,
    RoomState state,
  ) async* {
    if (state.textController.text.length == 0) {
      _error.addError(ErrorModel(message: 'Вы не ввели ни одного символа!'));
    }
    _ws.sendMessage(SendMessageRequest(
      text: state.textController.text,
      room: state.roomId,
    ));
  }

  RoomState _mapMessageAddedToState(
    MessageAdded event,
    RoomState state,
  ) {
    state.messages.add(event.message);

    return state.copyWith(messages: state.messages, version: state.version + 1);
  }

  RoomState _mapInputChangedToState(
    InputChanged event,
    RoomState state,
  ) {
    return state.copyWith();
  }
}
