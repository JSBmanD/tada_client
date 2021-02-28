import 'package:tada_client/service/common/storage/storage_box.dart';

/// Хранилище пользовательских настроек
class UserSettingsStorage extends StorageBox<dynamic> {
  static const _userName = 'name';

  UserSettingsStorage() : super(boxName: 'user_settings');

  // Имя юзера
  String get name => this.getByKey(_userName) as String;

  set name(String val) => this.addOrUpdate(_userName, val);

//#region Вспомогательные функции

  /// Проверяет, залогинен ли пользователь
  bool isLoggedIn() => name != null && name.isNotEmpty;

  /// Очищает данные пользователя
  void clearData() {
    name = null;
  }

//#endregion
}
