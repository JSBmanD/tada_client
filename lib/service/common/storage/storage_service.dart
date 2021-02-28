import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tada_client/service/common/storage/storages/user_settings_storage.dart';

/// Служба доступа к контейнерам хранилища
class StorageService {
  // Хранилища
  UserSettingsStorage userSettings = UserSettingsStorage();

  /// Инициализировать сервис
  Future<void> init() async {
    await Hive.initFlutter();
    // Стартуем таски
    final futures = <Future>[userSettings.init()];
    // Ожидаем пока все таски не завершаться
    await Future.wait(futures);
  }
}
