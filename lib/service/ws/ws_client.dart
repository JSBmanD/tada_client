import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tada_client/service/ws/messaging/dto/SendMessageRequest.dart';
import 'package:websok/io.dart';

/// Базовый класс API клиента
class WSClient {
  final IOWebsok websocket;
  final BehaviorSubject onData;
  final BehaviorSubject onError;
  final BehaviorSubject onDone;

  WSClient({
    @required this.websocket,
    this.onData,
    this.onError,
    this.onDone,
  }) : assert(websocket != null) {
    websocket
      ..listen(
        onData: (data) {
          onData.add(data);
        },
        onError: (error) {
          onError.add(error);
        },
        onDone: () {
          onDone.add(true);
        },
      );
  }

  /// Отправляет сообщение
  Future<void> sendMessage(SendMessageRequest request) async {
    final requestString = request.toJsonString();
    print(requestString);
    websocket.send(requestString);
  }

/*  void onData(dynamic message) {
    //final parsed = MessageDto.fromJson(json.decode(message));
    messagesSubscription.add(message);
    print(message);
  }*/

  Future<void> ping() async {
    websocket.send('{"ping": true}');
  }
}
