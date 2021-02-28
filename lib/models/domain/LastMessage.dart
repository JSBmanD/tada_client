import 'package:tada_client/models/domain/Sender.dart';

class LastMessage {
  LastMessage({this.room, this.created, this.sender, this.text});

  final String room;
  final String created;
  final Sender sender;
  final String text;
}
