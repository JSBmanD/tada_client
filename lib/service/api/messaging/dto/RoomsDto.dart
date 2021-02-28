import 'package:tada_client/service/api/messaging/dto/SenderDto.dart';

class RoomsDto {
  List<ResultDto> result;

  RoomsDto({this.result});

  RoomsDto.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<ResultDto>();
      json['result'].forEach((v) {
        result.add(new ResultDto.fromJson(v));
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

class ResultDto {
  String name;
  LastMessageDto lastMessage;

  ResultDto({this.name, this.lastMessage});

  ResultDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastMessage = json['last_message'] != null
        ? new LastMessageDto.fromJson(json['last_message'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage.toJson();
    }
    return data;
  }
}

class LastMessageDto {
  String room;
  String created;
  SenderDto sender;
  String text;

  LastMessageDto({this.room, this.created, this.sender, this.text});

  LastMessageDto.fromJson(Map<String, dynamic> json) {
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
