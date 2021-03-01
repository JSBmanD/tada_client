import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tada_client/helpers/custom_ticker.dart';
import 'package:tada_client/models/error_model.dart';
import 'package:tada_client/service/business_logic/settings_service.dart';
import 'package:tada_client/service/common/connectivity/connectivity_service.dart';
import 'package:tada_client/service/common/log/error_service.dart';
import 'package:tada_client/service/common/storage/storage_service.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({@required CustomTicker ticker, SplashState initialState})
      : assert(ticker != null),
        _ticker = ticker,
        super(initialState);

  /// Тикер таймера
  final CustomTicker _ticker;

  final SettingsService _settings = Get.find();
  final StorageService _storage = Get.find();
  final ConnectivityService _connect = Get.find();
  final ErrorService _error = Get.find();

  StreamSubscription<int> _tickerSubscription;
  bool needUpdate = false;

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is StartLoading) {
      yield* _mapTimerStartedToState(event, state);
    } else if (event is SplashTimerTicked) {
      yield* _mapTimerTickedToState(event, state);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<SplashState> _mapTimerStartedToState(
      StartLoading event, SplashState state) async* {
    if (_storage.userSettings.maxUsernameLength == null) {
      _connect.connectionStatus.listen((value) {
        if (value && needUpdate) {
          needUpdate = false;
          add(StartLoading());
        } else if (!value) {
          needUpdate = true;
        }
      });
      try {
        final settings = await _settings.getSettings();
        _storage.userSettings.maxUsernameLength = settings.maxUsernameLength;
        _storage.userSettings.maxRoomTitleLength = settings.maxRoomTitleLength;
        _storage.userSettings.maxMessageLength = settings.maxMessageLength;
        add(StartLoading());
      } on DioError catch (e) {
        if (!(e.error is String) && e.error.osError.errorCode == 7) {
          _error.addError(ErrorModel(message: 'Отсутствует подключение'));
        } else
          _error.addError(ErrorModel(message: 'Ошибка при получении данных'));
      } catch (e) {
        _error.addError(ErrorModel(message: 'Системная ошибка'));
      }
    } else {
      _tickerSubscription?.cancel();
      _tickerSubscription =
          _ticker.tick(ticks: state.ticksUntilEnd).listen((duration) {
        add(SplashTimerTicked(duration: duration));
      });
    }
  }

  Stream<SplashState> _mapTimerTickedToState(
      SplashTimerTicked event, SplashState state) async* {
    yield event.duration > 0
        ? state.copyWith(ticksUntilEnd: event.duration)
        : state.copyWith(initFinished: true);
  }
}
