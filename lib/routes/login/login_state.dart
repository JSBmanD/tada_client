part of 'login_bloc.dart';

class LoginState extends Equatable {
  LoginState({
    this.name,
    this.loginSuccess = false,
  });

  /// Введенное имя
  final String name;

  /// Успешный логин
  final bool loginSuccess;

  @override
  List<Object> get props => [
        name,
        loginSuccess,
      ];

  LoginState copyWith({
    String name,
    bool loginSuccess,
  }) {
    return LoginState(
      name: name ?? this.name,
      loginSuccess: loginSuccess ?? this.loginSuccess,
    );
  }
}
