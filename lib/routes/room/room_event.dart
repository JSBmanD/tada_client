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

/// Отправить сбщ
class SendMessage extends RoomEvent {
  @override
  List<Object> get props => [];
}

/// Поменялся коммент в инпуте
class CommentChanged extends RoomEvent {
  CommentChanged({@required this.value});

  final String value;

  @override
  List<Object> get props => [value];
}
