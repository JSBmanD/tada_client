import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_client/app_container.dart';
import 'package:tada_client/helpers/error_reporter_helper.dart';
import 'package:tada_client/models/error_model.dart';
import 'package:tada_client/routes/splash/splash_view.dart';
import 'package:tada_client/service/common/di/injections.dart';
import 'package:tada_client/service/common/log/error_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Определим зависимости
  await Injections.inject();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TadaClient(),
    );
  }
}

class TadaClient extends StatefulWidget {
  const TadaClient({Key key}) : super(key: key);

  @override
  _TadaClientState createState() => _TadaClientState();
}

class _TadaClientState extends State<TadaClient> {
  final ErrorService _errors = Get.find();

  StreamSubscription<ErrorModel> _errorSubscription;

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
        default:
          ErrorReporterHelper.reportMinor(event);
          break;
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    _errorSubscription.cancel();
  }

  void closePage() {}

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GetMaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/splashscreen',
        getPages: [
          GetPage(
            name: '/splashscreen',
            page: () => SplashView(),
          ),
        ],
        builder: (context, child) {
          return MediaQuery(
            child: AppContainer(
              child: child,
            ),
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
      ),
    );
  }
}
