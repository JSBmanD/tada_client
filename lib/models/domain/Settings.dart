/// Модель настроек
class Settings {
  Settings(
      {this.maxMessageLength,
      this.maxRoomTitleLength,
      this.maxUsernameLength,
      this.uptime});

  /// Макс длина сбщ
  final int maxMessageLength;

  /// Макс длина тайтла рума
  final int maxRoomTitleLength;

  /// Макс длина юзернейма
  final int maxUsernameLength;

  /// Аптайм
  final int uptime;
}
