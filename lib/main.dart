import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_client/app_container.dart';
import 'package:tada_client/routes/splash/splash_view.dart';
import 'package:tada_client/service/common/di/injections.dart';

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
