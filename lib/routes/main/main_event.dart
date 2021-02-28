part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {}

/// Получить все проекты
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
