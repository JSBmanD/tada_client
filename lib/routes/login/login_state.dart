part of 'login_bloc.dart';

class LoginState extends Equatable {
  LoginState({
    this.name,
    this.loginSuccess = false,
    this.version = 0,
  });

  final String name;
  final bool loginSuccess;
  final int version;

  @override
  List<Object> get props => [
        name,
        loginSuccess,
        version,
      ];

  LoginState copyWith({
    int version,
    String name,
    bool loginSuccess,
  }) {
    return LoginState(
      name: name ?? this.name,
      version: version ?? this.version,
      loginSuccess: loginSuccess ?? this.loginSuccess,
    );
  }
}
