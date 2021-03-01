import 'package:get/get.dart';
import 'package:tada_client/models/domain/Settings.dart';
import 'package:tada_client/service/api/api_service.dart';
import 'package:tada_client/service/api/settings/api_settings.dart';

/// Сервис настроек
class SettingsService {
  ApiSettings _settings;

  SettingsService() {
    _settings = Get.find<ApiService>().getSettingsClient();
  }

  /// Получить настройки
  Future<Settings> getSettings() async {
    return await _settings.getSettings();
  }
}
