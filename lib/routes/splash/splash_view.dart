import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tada_client/helpers/custom_ticker.dart';
import 'package:tada_client/routes/main/main_tabs.dart';
import 'package:tada_client/routes/splash/splash_bloc.dart';
import 'package:tada_client/service/common/styles/styles_service.dart';

/// Сплэш скрин
class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(ticker: CustomTicker()),
      child: _SplashViewState(),
    );
  }
}

class _SplashViewState extends StatelessWidget {
  final StylesService _styles = Get.find();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      builder: (context, state) {
        if (state is SplashInit) {
          BlocProvider.of<SplashBloc>(context)
              .add(SplashLoadStarted(state.duration));
        }
        return Material(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Tada Client\n',
                    style: _styles.theme.subhead2TextStyle.copyWith(
                      color: _styles.theme.primaryTextColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'by\n',
                        style: _styles.theme.subhead2TextStyle.copyWith(
                          color: _styles.theme.primaryTextColor,
                        ),
                      ),
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
          ),
        );
      },
      listener: (BuildContext context, state) {
        if (state is SplashFinished) {
          Get.offAll(() => MainTabs());
          return;
        }
      },
    );
  }
}
