import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:tada_client/service/common/storage/storage_service.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(MainState initialState) : super(initialState);

  final StorageService _storage = Get.find();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is InitRooms) {
      yield* _mapInitRoomsToState(event, state);
    } else if (event is Logout) {
      yield _mapLogoutToState(event, state);
    } else if (event is LoginSuccess) {
      yield state.copyWith(isLoggedIn: true);
    }
  }

  Stream<MainState> _mapInitRoomsToState(
    InitRooms event,
    MainState state,
  ) async* {
    yield state.copyWith(isLoggedIn: _storage.userSettings.isLoggedIn());
    return;
  }

  MainState _mapLogoutToState(
    Logout event,
    MainState state,
  ) {
    _storage.userSettings.clearData();
    return state.copyWith(isLoggedIn: false);
  }
}
