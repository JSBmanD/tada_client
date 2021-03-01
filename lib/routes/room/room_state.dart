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
  final String roomId;
  final String comment;
  final List<Message> messages;
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
