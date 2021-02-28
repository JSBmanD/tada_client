import 'package:tada_client/models/domain/Sender.dart';

class Message {
  Message({this.room, this.created, this.sender, this.text});

  final String room;
  final DateTime created;
  final Sender sender;
  final String text;
}
