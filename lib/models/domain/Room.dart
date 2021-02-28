import 'package:tada_client/models/domain/Message.dart';

class Room {
  Room({this.name, this.lastMessage});

  final String name;
  Message lastMessage;
}
