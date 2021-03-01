import 'package:flutter/cupertino.dart';
import 'package:tada_client/service/ws/messaging/dto/SendMessageRequest.dart';
import 'package:tada_client/service/ws/ws_client.dart';

/// Ендпоинты отправки сбщ по вс
class WsMessaging {
  final WSClient client;

  WsMessaging({@required this.client}) : assert(client != null);

  Future<bool> sendMessage(SendMessageRequest request) async {
    await client.sendMessage(request);
    return true;
  }
}
