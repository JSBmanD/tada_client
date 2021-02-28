import 'dart:async';

import 'package:tada_client/service/ws/messaging/dto/SendMessageRequest.dart';
import 'package:tada_client/service/ws/ws_client.dart';
import 'package:websok/io.dart';

/// Реализует доступ к вебсокету
class WSService {
  WSClient _client;
  StreamSubscription<dynamic> _messagesSubscription;

  void onData(dynamic message) => print(message);

  void onError(dynamic message) => print('Error $message');

  void onDone() => print('Done');

  WSService() {
    final websok =
        IOWebsok(host: 'nane.tada.team/ws?username=Test@kozma', tls: true)
          ..connect()
          ..listen(
            onData: onData,
            onError: onError,
            onDone: onDone,
          );
    _messagesSubscription = websok.channel.stream.listen((event) {});
    _client = WSClient(websocket: websok);
  }

  Future<void> cancelService() async {
    await _messagesSubscription?.cancel();
  }

  Future<void> sendMessage(SendMessageRequest request) async {
    _client.sendMessage(request);
  }
}
