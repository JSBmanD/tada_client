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
          if (onData != null && !onData.isClosed) onData.add(data);
        },
        onError: (error) {
          if (onError != null && !onError.isClosed) onError.add(error);
        },
        onDone: () {
          if (onDone != null && !onDone.isClosed) onDone.add(true);
        },
      );
  }

  /// Отправляет сообщение
  Future<void> sendMessage(SendMessageRequest request) async {
    final requestString = request.toJsonString();
    print(requestString);
    websocket.send(requestString);
  }

  Future<void> ping() async {
    websocket.send('{"ping": true}');
  }

  Future<void> cancelAllListeners() async {
    if (websocket?.isActive ?? false) await websocket?.close();
  }
}
