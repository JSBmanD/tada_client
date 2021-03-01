part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {}

/// Получить все комнаты
class InitRooms extends MainEvent {
  @override
  List<Object> get props => [];
}

class Logout extends MainEvent {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends MainEvent {
  @override
  List<Object> get props => [];
}

/// Пришло сообщение
class MessageAdded extends MainEvent {
  MessageAdded({@required this.message});

  final Message message;

  @override
  List<Object> get props => [message];
}

class OpenRoom extends MainEvent {
  OpenRoom({@required this.roomId});

  final String roomId;

  @override
  List<Object> get props => [roomId];
}

class ClosePage extends MainEvent {
  @override
  List<Object> get props => [];
}
