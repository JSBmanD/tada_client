part of 'main_bloc.dart';

/// Базовый класс состояния экрана проектов
class MainState extends Equatable {
  MainState({
    this.version = 0,
    this.isLoggedIn = false,
  });

  /// Версия для держании блока в курсе стейта
  final int version;
  final bool isLoggedIn;

  @override
  List<Object> get props => [
        version,
        isLoggedIn,
      ];

  MainState copyWith({
    int version,
    bool isLoggedIn,
  }) {
    return MainState(
      version: version ?? this.version,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
