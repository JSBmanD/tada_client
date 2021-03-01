/// Дто пинга
class PingDto {
  bool pong;

  PingDto({this.pong});

  PingDto.fromJson(Map<String, dynamic> json) {
    pong = json['pong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pong'] = this.pong;
    return data;
  }
}
