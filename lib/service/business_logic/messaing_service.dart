import 'package:get/get.dart';
import 'package:tada_client/models/domain/Room.dart';
import 'package:tada_client/service/api/api_service.dart';
import 'package:tada_client/service/api/messaging/api_messaging.dart';
import 'package:tada_client/service/common/storage/storage_service.dart';

/// Сервис сообщений
class MessagingService {
  StorageService _storage;
  ApiMessaging _messaging;

  MessagingService() {
    _storage = Get.find();
    _messaging = Get.find<ApiService>().getMessagingClient();
  }

  Future<List<Room>> getRooms() async {
    return await _messaging.getRooms();
  }
}
