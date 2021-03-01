import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tada_client/helpers/custom_ticker.dart';
import 'package:tada_client/helpers/image_names.dart';
import 'package:tada_client/routes/main/main_tabs.dart';
import 'package:tada_client/routes/splash/splash_bloc.dart';
import 'package:tada_client/service/common/image/image_service.dart';
import 'package:tada_client/service/common/styles/styles_service.dart';

/// Сплэш скрин
class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SplashBloc(ticker: CustomTicker(), initialState: SplashState())
            ..add(StartLoading()),
      child: _SplashViewState(),
    );
  }
}

class _SplashViewState extends StatelessWidget {
  final StylesService _styles = Get.find();
  final ImageService _image = Get.find();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      builder: (context, state) {
        return Material(
          color: _styles.theme.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image.commonImage(ImageNames.logo),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'by\n',
                  style: _styles.theme.subhead2TextStyle.copyWith(
                    color: _styles.theme.primaryTextColor,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'JSBmanD',
                      style: _styles.theme.subhead1TextStyle.copyWith(
                        color: _styles.theme.primaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      listener: (BuildContext context, state) {
        if (state.initFinished) {
          Get.offAll(() => MainTabs());
          return;
        }
      },
    );
  }
}
