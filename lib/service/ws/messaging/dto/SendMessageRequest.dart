import 'dart:convert';

/// Запрос на отправку сбщ
class SendMessageRequest {
  SendMessageRequest({
    this.room,
    this.text,
    this.id,
  });

  final String room;
  final String text;
  final String id;

  String toJsonString() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['room'] = this.room;
    data['text'] = this.text;
    if (this.id != null) data['id'] = this.id;

    return json.encode(data);
  }
}
