part of 'splash_bloc.dart';

/// Базовый класс состояния сплеша
abstract class SplashState extends Equatable {
  final int duration;

  const SplashState(this.duration);

  @override
  List<Object> get props => [];
}

/// Инициализация
class SplashInit extends SplashState {
  SplashInit(int duration) : super(duration);
}

/// Загрузка
class SplashProgress extends SplashState {
  SplashProgress(int duration) : super(duration);
}

/// Завершение
class SplashFinished extends SplashState {
  SplashFinished(int duration) : super(duration);
}

/// Ошибка
class SplashError extends SplashState {
  final String message;

  const SplashError({@required this.message})
      : assert(message != null),
        super(0);

  @override
  List<Object> get props => [message];
}
