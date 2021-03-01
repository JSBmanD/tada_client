import 'package:tada_client/models/domain/Sender.dart';

class Message {
  Message({
    this.room,
    this.created,
    this.sender,
    this.text,
    this.id,
  });

  final String room;
  final DateTime created;
  final Sender sender;
  final String text;
  final String id;
}
