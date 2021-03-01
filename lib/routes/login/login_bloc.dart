import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tada_client/helpers/regex_helper.dart';
import 'package:tada_client/models/error_model.dart';
import 'package:tada_client/service/business_logic/authorization_service.dart';
import 'package:tada_client/service/common/log/error_service.dart';
import 'package:tada_client/service/common/storage/storage_service.dart';
import 'package:tada_client/service/ws/ws_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);

  final AuthorizationService _authorization = Get.find();
  final ErrorService _errorService = Get.find();
  final WSService _ws = Get.find();
  final StorageService _storage = Get.find();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginChanged) {
      yield* _mapLoginChangedToState(event, state);
    } else if (event is Login) {
      yield* _mapLoginToState(event, state);
    }
  }

  Stream<LoginState> _mapLoginChangedToState(
    LoginChanged event,
    LoginState state,
  ) async* {
    yield state.copyWith(
      name: event.input,
    );
  }

  Stream<LoginState> _mapLoginToState(
    Login event,
    LoginState state,
  ) async* {
    final name = RegexHelper.removeUnneededSpaces(state.name);
    if (name.isEmpty) {
      _errorService.addError(ErrorModel(
        message: 'Вы не ввели имя',
      ));
      return;
    } else if (name.length > _storage.userSettings.maxUsernameLength) {
      _errorService.addError(ErrorModel(
        message: 'Ваше имя слишком длинное',
      ));
      return;
    }

    await _authorization.auth(name: name);
    await _ws.init();
    yield state.copyWith(
      loginSuccess: true,
    );
  }
}
