import 'package:tada_client/service/api/messaging/dto/SenderDto.dart';

/// DTO сообщения
class MessageDto {
  /// Название комнаты
  String room;

  /// Дата создания
  String created;

  /// Отправитель
  SenderDto sender;

  /// Сообщение
  String text;

  MessageDto({this.room, this.created, this.sender, this.text});

  MessageDto.fromJson(Map<String, dynamic> json) {
    room = json['room'];
    created = json['created'];
    sender =
        json['sender'] != null ? new SenderDto.fromJson(json['sender']) : null;
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room'] = this.room;
    data['created'] = this.created;
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    data['text'] = this.text;
    return data;
  }
}
