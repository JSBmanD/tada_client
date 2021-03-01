import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_client/helpers/error_reporter_helper.dart';
import 'package:tada_client/models/error_model.dart';
import 'package:tada_client/service/common/connectivity/connectivity_service.dart';
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
  final ConnectivityService _connect = Get.find();

  /// Все ли ок с сетью
  bool isConnectedToInternet = true;

  StreamSubscription<ErrorModel> _errorSubscription;
  StreamSubscription<bool> _connectionSubscription;

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

    _connectionSubscription = _connect.connectionStatus.listen((value) {
      setState(() {
        isConnectedToInternet = value;
      });
    });
  }

  @override
  dispose() {
    super.dispose();
    _errorSubscription.cancel();
    _connectionSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        isConnectedToInternet
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
                                'Отсутствует подключение к серверу. Все функциии приложения могут работать некорректно.',
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
}
