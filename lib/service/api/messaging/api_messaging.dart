import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tada_client/models/domain/Message.dart';
import 'package:tada_client/models/domain/Room.dart';
import 'package:tada_client/models/domain/Sender.dart';
import 'package:tada_client/service/api/api_client.dart';
import 'package:tada_client/service/api/messaging/dto/RoomsDto.dart';

/// Ендпоинты проектов
class ApiMessaging {
  final ApiClient client;

  ApiMessaging({@required this.client}) : assert(client != null);

  /// Получает проекты пользователя
  Future<List<Room>> getRooms() async {
    const url = '/rooms';

    final response = await client.get(url);
    if (response.statusCode != 200)
      throw DioError(
        type: DioErrorType.RESPONSE,
        error: 'System error',
        response: Response(statusCode: response.statusCode),
      );
    final parsed = RoomsDto.fromJson(response.data);

    final result = parsed.result
        .map((e) => Room(
              name: e.name,
              lastMessage: Message(
                text: e.lastMessage.text,
                created: DateTime.parse(e.lastMessage.created),
                room: e.lastMessage.room,
                sender: Sender(
                  username: e.lastMessage.sender.username,
                ),
              ),
            ))
        .toList();

    return result;
  }
}
