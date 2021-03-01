import 'package:tada_client/models/domain/Sender.dart';

/// Модель сообщения
class Message {
  Message({
    this.room,
    this.created,
    this.sender,
    this.text,
    this.id,
  });

  /// Комната
  final String room;

  /// Время создания
  final DateTime created;

  /// Отправитель
  final Sender sender;

  /// Сообщение
  final String text;

  /// Ид сообщения
  final String id;
}
