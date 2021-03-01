class SettingsDto {
  ResultDto result;

  SettingsDto({this.result});

  SettingsDto.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new ResultDto.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class ResultDto {
  int maxMessageLength;
  int maxRoomTitleLength;
  int maxUsernameLength;
  int uptime;

  ResultDto(
      {this.maxMessageLength,
      this.maxRoomTitleLength,
      this.maxUsernameLength,
      this.uptime});

  ResultDto.fromJson(Map<String, dynamic> json) {
    maxMessageLength = json['max_message_length'];
    maxRoomTitleLength = json['max_room_title_length'];
    maxUsernameLength = json['max_username_length'];
    uptime = json['uptime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max_message_length'] = this.maxMessageLength;
    data['max_room_title_length'] = this.maxRoomTitleLength;
    data['max_username_length'] = this.maxUsernameLength;
    data['uptime'] = this.uptime;
    return data;
  }
}
