import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:tada_client/service/ws/messaging/dto/SendMessageRequest.dart';
import 'package:websok/io.dart';

/// Базовый класс API клиента
class WSClient {
  final IOWebsok websocket;

  WSClient({@required this.websocket}) : assert(websocket != null);

  Future<void> ping() async {}

  /// Отправляет сообщение
  Future<void> sendMessage(SendMessageRequest request) async {
    final requestString = request.toJsonString();
    print(requestString);
    websocket.send(requestString);
  }
}
