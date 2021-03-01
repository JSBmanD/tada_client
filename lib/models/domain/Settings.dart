class Settings {
  Settings(
      {this.maxMessageLength,
      this.maxRoomTitleLength,
      this.maxUsernameLength,
      this.uptime});

  final int maxMessageLength;
  final int maxRoomTitleLength;
  final int maxUsernameLength;
  final int uptime;
}
