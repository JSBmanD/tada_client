import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:tada_client/models/domain/Message.dart';
import 'package:tada_client/models/domain/Sender.dart';
import 'package:tada_client/service/ws/messaging/dto/MessageDto.dart';
import 'package:tada_client/service/ws/messaging/dto/SendMessageRequest.dart';
import 'package:tada_client/service/ws/ws_client.dart';
import 'package:websok/io.dart';

/// Реализует доступ к вебсокету
class WSService {
  WSClient _client;

  BehaviorSubject<Message> messageListener;
  BehaviorSubject onData;
  BehaviorSubject onError;
  BehaviorSubject onDone;

  WSService() {
    final websok =
        IOWebsok(host: 'nane.tada.team/ws?username=Test@kozma', tls: true)
          ..connect();

    messageListener = BehaviorSubject();
    onData = BehaviorSubject()
      ..listen((value) {
        final parsed = MessageDto.fromJson(json.decode(value));
        final response = Message(
            room: parsed.room,
            created: DateTime.parse(parsed.created),
            text: parsed.text,
            sender: Sender(
              username: parsed.sender.username,
            ));
        messageListener.add(response);
      });
    onError = BehaviorSubject();
    onDone = BehaviorSubject();
    _client = WSClient(websocket: websok, onData: onData);
  }

  Future<void> cancelService() async {
    await messageListener?.close();
    await onData?.close();
    await onError?.close();
    await onDone?.close();
  }

  Future<void> sendMessage(SendMessageRequest request) async {
    _client.sendMessage(request);
  }
}
