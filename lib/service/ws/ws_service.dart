import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tada_client/models/domain/Message.dart';
import 'package:tada_client/models/domain/Sender.dart';
import 'package:tada_client/service/common/storage/storage_service.dart';
import 'package:tada_client/service/ws/messaging/dto/MessageDto.dart';
import 'package:tada_client/service/ws/messaging/dto/SendMessageRequest.dart';
import 'package:tada_client/service/ws/ping/PingDto.dart';
import 'package:tada_client/service/ws/ws_client.dart';
import 'package:websok/io.dart';

/// Реализует доступ к вебсокету
class WSService {
  final StorageService _storage = Get.find();

  WSClient _client;

  BehaviorSubject<Message> messageListener;
  BehaviorSubject<bool> connectionListener;
  BehaviorSubject onData;
  BehaviorSubject onError;
  BehaviorSubject onDone;

  Future<void> init() async {
    await cancelService();
    final websok = IOWebsok(
        host: 'nane.tada.team/ws?username=${_storage.userSettings.name}',
        tls: true)
      ..connect();

    messageListener = BehaviorSubject();
    connectionListener = BehaviorSubject();

    onData = BehaviorSubject()
      ..listen((value) {
        try {
          final parsed = MessageDto.fromJson(json.decode(value));
          final response = Message(
              room: parsed.room,
              created: DateTime.parse(parsed.created),
              text: parsed.text,
              id: parsed.id,
              sender: Sender(
                username: parsed.sender.username,
              ));
          messageListener.add(response);
        } catch (_) {
          try {
            PingDto.fromJson(json.decode(value));
            connectionListener.add(true);
          } catch (_) {
            connectionListener.add(false);
          }
        }
      });
    onError = BehaviorSubject()
      ..listen((value) {
        init();
      });
    onDone = BehaviorSubject()
      ..listen((value) {
        init();
      });
    _client = WSClient(websocket: websok, onData: onData);
  }

  Future<void> cancelService() async {
    await _client?.cancelAllListeners();
    _client = null;
    await messageListener?.close();
    await onData?.close();
    await onError?.close();
    await onDone?.close();
  }

  Future<void> sendMessage(SendMessageRequest request) async {
    _client?.sendMessage(request);
  }

  Future<void> ping() async {
    _client?.ping();
  }
}
