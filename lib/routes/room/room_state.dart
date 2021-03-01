part of 'room_bloc.dart';

/// Базовый класс состояния экрана комнаты
class RoomState extends Equatable {
  RoomState( {
    this.version = 0,
    this.messages,
    this.textController,this.roomId,
  }) {
    this.textController = TextEditingController();
  }

  /// Версия для держании блока в курсе стейта
  final int version;
  final String roomId;
  final List<Message> messages;
  TextEditingController textController;

  @override
  List<Object> get props => [
        version,
      ];

  RoomState copyWith({
    int version,
    List<Message> messages,
    TextEditingController textController,String roomId,
  }) {
    return RoomState(
      version: version ?? this.version,
      messages: messages ?? this.messages,
      textController: textController ?? this.textController,
      roomId: roomId ?? this.roomId,
    );
  }
}
