import 'package:tada_client/service/common/storage/storage_box.dart';

/// Хранилище пользовательских настроек
class UserSettingsStorage extends StorageBox<dynamic> {
  static const _userName = 'name';
  static const _maxMessageLength = 'maxMessageLength';
  static const _maxRoomTitleLength = 'maxRoomTitleLength';
  static const _maxUsernameLength = 'maxUsernameLength';

  UserSettingsStorage() : super(boxName: 'user_settings');

  // Имя юзера
  String get name => this.getByKey(_userName) as String;

  set name(String val) => this.addOrUpdate(_userName, val);

  // Макс длина сбщ
  int get maxMessageLength => this.getByKey(_maxMessageLength) as int;

  set maxMessageLength(int val) => this.addOrUpdate(_maxMessageLength, val);

  // Макс длина названия комнаты
  int get maxRoomTitleLength => this.getByKey(_maxRoomTitleLength) as int;

  set maxRoomTitleLength(int val) => this.addOrUpdate(_maxRoomTitleLength, val);

  // Макс длина юзернейма
  int get maxUsernameLength => this.getByKey(_maxUsernameLength) as int;

  set maxUsernameLength(int val) => this.addOrUpdate(_maxUsernameLength, val);

//#region Вспомогательные функции

  /// Проверяет, залогинен ли пользователь
  bool isLoggedIn() => name != null && name.isNotEmpty;

  /// Очищает данные пользователя
  void clearData() {
    name = null;
  }

//#endregion
}
