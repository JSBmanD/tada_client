import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tada_client/service/ws/ws_service.dart';

/// Сервис для проверки состояния инета
class ConnectivityService {
  final WSService _ws = Get.find();

  /// Стрим со статусом коннекта
  BehaviorSubject<bool> connectionStatus;

  /// Подключен ли к инету
  bool isConnectedToInternet = true;

  Future<void> init() async {
    connectionStatus = BehaviorSubject();

    _ws.connectionListener.listen((value) {
      isConnectedToInternet = value;
      if (!value)
        Timer(Duration(seconds: 5), () {
          _checkServerStatus();
        });
    });

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
          // Если только что восстановили соединение с интернетом - пинганем сервер
          if (!isConnectedToInternet) _checkServerStatus();
          isConnectedToInternet = true;

          _ws.init();
          break;
        case ConnectivityResult.none:
          isConnectedToInternet = false;
          break;
      }
      connectionStatus.add(isConnectedToInternet);
    });

    await _firstCheckup();
  }

  _firstCheckup() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _checkServerStatus();
    } else {
      isConnectedToInternet = false;
    }
    connectionStatus.add(isConnectedToInternet);
  }

  _checkServerStatus() async {
    _ws.ping();
  }
}
