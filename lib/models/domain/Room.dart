import 'package:tada_client/models/domain/LastMessage.dart';

class Room {
  Room({this.name, this.lastMessage});

  final String name;
  final LastMessage lastMessage;
}
