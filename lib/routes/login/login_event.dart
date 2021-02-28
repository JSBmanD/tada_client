part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class LoginChanged extends LoginEvent {
  LoginChanged({@required this.input});

  final String input;

  @override
  List<Object> get props => [input];
}

class Login extends LoginEvent {
  @override
  List<Object> get props => [];
}
