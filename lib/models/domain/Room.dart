import 'package:tada_client/models/domain/Message.dart';

/// Модель комнаты
class Room {
  Room({this.name, this.lastMessage});

  /// Название
  final String name;

  /// Последнее сообщение
  Message lastMessage;
}
