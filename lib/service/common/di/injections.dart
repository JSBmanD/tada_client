import 'package:get/get.dart';
import 'package:tada_client/service/api/api_service.dart';
import 'package:tada_client/service/business_logic/authorization_service.dart';
import 'package:tada_client/service/business_logic/messaing_service.dart';
import 'package:tada_client/service/common/image/image_service.dart';
import 'package:tada_client/service/common/log/error_service.dart';
import 'package:tada_client/service/common/storage/storage_service.dart';
import 'package:tada_client/service/common/styles/styles_service.dart';
import 'package:tada_client/service/ws/ws_service.dart';

/// Регистрирует зависимости
/// https://pub.dev/packages/get
class Injections {
  static inject() async {
    // Сервис стореджа
    final storage = StorageService();
    await storage.init();
    Get.put(storage);
    // Сервис стилей
    final styles = StylesService();
    await styles.init();
    Get.put(styles);
    // Сервис ошибок
    Get.put(ErrorService());
    // Сервис апи
    Get.put(ApiService());
    // Сервис авторизации
    Get.put(AuthorizationService());
    // Сервис картинок
    Get.put(ImageService());
    // Сервис вебсокета
    Get.put(WSService());
    // Сервис сообщений
    Get.put(MessagingService());
  }
}
