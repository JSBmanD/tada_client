import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_client/helpers/error_reporter_helper.dart';
import 'package:tada_client/models/error_model.dart';
import 'package:tada_client/service/api/api_service.dart';
import 'package:tada_client/service/common/log/error_service.dart';

/// Главный контейнер приложения
class AppContainer extends StatefulWidget {
  const AppContainer({Key key, this.child}) : super(key: key);

  /// Контент
  final Widget child;

  @override
  _AppContainerState createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  final ErrorService _errors = Get.find();

  /// АПИ сервис
  final ApiService _api = Get.find();

  /// Все ли ок с сетью
  bool networkIsOk = true;
  bool isConnectedToInternet = true;

  StreamSubscription<ErrorModel> _errorSubscription;
  StreamSubscription<ConnectivityResult> _networkStatus;

  @override
  initState() {
    super.initState();
    _errorSubscription = _errors.events.listen((event) {
      switch (event.priority) {
        case ErrorPriority.CRITICAL:
          ErrorReporterHelper.reportCritical(event);
          break;
        case ErrorPriority.WARNING:
          ErrorReporterHelper.reportWarning(event);
          break;
        case ErrorPriority.MINOR:
          ErrorReporterHelper.reportMinor(event);
          break;
        default:
          ErrorReporterHelper.reportInfo(event);
          break;
      }
    });

    /* _networkStatus = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
          // Если только что восстановили соединение с интернетом - пинганем сервер
          if (!isConnectedToInternet) _checkServerStatus();
          setState(() {
            isConnectedToInternet = true;
          });
          break;
        case ConnectivityResult.none:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
      }
    });

    _checkServerStatus();*/
  }

  _checkServerStatus() {
    /*_api.serverStatus().then((value) {
      this.setState(() {
        networkIsOk = value;
      });
      if (!value) {
        // Если коннекта с АПИ нет - повторим проверку через 5 секунд
        Timer(Duration(seconds: 5), () {
          _checkServerStatus();
        });
      }
    });*/
  }

  @override
  dispose() {
    super.dispose();
    _errorSubscription.cancel();
    _networkStatus?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        networkIsOk && isConnectedToInternet
            ? const SizedBox.shrink()
            : Align(
                alignment: Alignment.bottomCenter,
                child: IgnorePointer(
                    child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.15),
                  child: Opacity(
                      opacity: 0.75,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 8,
                          ),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 120.0,
                          decoration: const BoxDecoration(
                              color: Color(0xCC000000),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          child: Column(
                            children: [
                              Icon(
                                Icons.cloud_off,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                _getLocalizedNetworkError(context),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      )),
                )),
              )
      ],
    );
  }

  String _getLocalizedNetworkError(BuildContext context) {
    switch (Localizations.localeOf(context)?.languageCode) {
      case 'ru':
        return 'Отсутствует подключение к серверу. Некоторые функциии приложения могут работать некорректно.';
      default:
        return 'Error during request to application server. Most features will be unavailable.';
    }
  }
}
