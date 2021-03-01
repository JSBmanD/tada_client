part of 'splash_bloc.dart';

/// Базовый класс событий Сплеш-скрина
abstract class SplashEvent extends Equatable {}

/// Событие начала загрузки
class StartLoading extends SplashEvent {
  @override
  List<Object> get props => [];
}

/// Событие тика таймера
class SplashTimerTicked extends SplashEvent {
  SplashTimerTicked({@required this.duration});

  final int duration;

  @override
  List<Object> get props => [duration];

  @override
  String toString() => 'TimerTicked { duration: $duration }';
}
