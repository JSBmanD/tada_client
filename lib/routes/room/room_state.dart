part of 'room_bloc.dart';

/// Базовый класс состояния экрана комнаты
class RoomState extends Equatable {
  RoomState({
    this.version = 0,
    this.messages,
    this.comment,
    this.roomId,
    this.textController,
  }) {
    textController = textController ?? TextEditingController();
  }

  /// Версия для держании блока в курсе стейта
  final int version;

  /// Ид комнаты
  final String roomId;

  /// Коммент в инпуте
  final String comment;

  /// Все сбщ
  final List<Message> messages;

  /// Контроллер сбщ
  TextEditingController textController;

  @override
  List<Object> get props => [
        version,
        roomId,
        comment,
        textController,
      ];

  RoomState copyWith({
    int version,
    List<Message> messages,
    String comment,
    String roomId,
    TextEditingController textController,
  }) {
    return RoomState(
      version: version ?? this.version,
      messages: messages ?? this.messages,
      comment: comment ?? this.comment,
      roomId: roomId ?? this.roomId,
      textController: textController ?? this.textController,
    );
  }
}
