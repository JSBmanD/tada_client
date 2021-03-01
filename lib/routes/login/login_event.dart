part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

/// Логин поменялся
class LoginChanged extends LoginEvent {
  LoginChanged({@required this.input});

  final String input;

  @override
  List<Object> get props => [input];
}

/// Залогиниться
class Login extends LoginEvent {
  @override
  List<Object> get props => [];
}
