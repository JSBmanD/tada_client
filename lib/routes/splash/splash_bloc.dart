import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tada_client/helpers/custom_ticker.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({@required CustomTicker ticker})
      : assert(ticker != null),
        _ticker = ticker,
        super(SplashInit(_duration));

  /// Тикер таймера
  final CustomTicker _ticker;

  /// Продолжительность таймера
  static const int _duration = 1;

  StreamSubscription<int> _tickerSubscription;

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is SplashLoadStarted) {
      // Инициализация стейта при начале загрузки
      yield* _mapTimerStartedToState(event);
    } else if (event is SplashTimerTicked) {
      // Обработка тика таймера
      yield* _mapTimerTickedToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<SplashState> _mapTimerStartedToState(SplashLoadStarted start) async* {
    yield SplashProgress(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(SplashTimerTicked(duration: duration)));
  }

  Stream<SplashState> _mapTimerTickedToState(SplashTimerTicked tick) async* {
    yield tick.duration > 0
        ? SplashProgress(tick.duration)
        : SplashFinished(tick.duration);
  }
}
