part of 'splash_bloc.dart';

/// Базовый класс состояния сплеша
class SplashState extends Equatable {
  SplashState({
    this.ticksUntilEnd = 1,
    this.initFinished = false,
  });

  /// Сколько осталось тиков до конца
  final int ticksUntilEnd;

  /// Инициализация завершена
  final bool initFinished;

  @override
  List<Object> get props => [
        ticksUntilEnd,
        initFinished,
      ];

  SplashState copyWith({
    int ticksUntilEnd,
    bool initFinished,
  }) {
    return SplashState(
      ticksUntilEnd: ticksUntilEnd ?? this.ticksUntilEnd,
      initFinished: initFinished ?? this.initFinished,
    );
  }
}
