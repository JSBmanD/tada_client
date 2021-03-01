import 'package:tada_client/models/domain/Sender.dart';
import 'package:tada_client/service/api/messaging/dto/SenderDto.dart';

class MessageListDto {
  List<Result> result;

  MessageListDto({this.result});

  MessageListDto.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String room;
  String created;
  SenderDto sender;
  String text;
  String id;

  Result({this.room, this.created, this.sender, this.text, this.id});

  Result.fromJson(Map<String, dynamic> json) {
    room = json['room'];
    created = json['created'];
    sender =
    json['sender'] != null ? new SenderDto.fromJson(json['sender']) : null;
    text = json['text'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room'] = this.room;
    data['created'] = this.created;
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    data['text'] = this.text;
    data['id'] = this.id;
    return data;
  }
}
