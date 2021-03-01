import 'package:get/get.dart';
import 'package:tada_client/models/domain/Message.dart';
import 'package:tada_client/models/domain/Room.dart';
import 'package:tada_client/service/api/api_service.dart';
import 'package:tada_client/service/api/messaging/api_messaging.dart';

/// Сервис сообщений
class MessagingService {
  ApiMessaging _messaging;

  MessagingService() {
    _messaging = Get.find<ApiService>().getMessagingClient();
  }

  Future<List<Room>> getRooms() async {
    return await _messaging.getRooms();
  }

  Future<List<Message>> getRoomMessages(String roomId) async {
    return await _messaging.getRoomMessages(roomId);
  }
}
