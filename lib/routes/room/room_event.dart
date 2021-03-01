part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable {}

/// Получить все сообщения
class InitRoom extends RoomEvent {
  InitRoom(this.roomId);

  final String roomId;

  @override
  List<Object> get props => [];
}

/// Пришло сообщение
class MessageAdded extends RoomEvent {
  MessageAdded({@required this.message});

  final Message message;

  @override
  List<Object> get props => [message];
}

class InputChanged extends RoomEvent {
  InputChanged({@required this.input});

  final String input;

  @override
  List<Object> get props => [input];
}

class SendMessage extends RoomEvent {
  @override
  List<Object> get props => [];
}
