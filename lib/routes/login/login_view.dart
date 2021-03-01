import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tada_client/helpers/image_names.dart';
import 'package:tada_client/routes/login/login_bloc.dart';
import 'package:tada_client/routes/main/main_bloc.dart';
import 'package:tada_client/service/common/image/image_service.dart';
import 'package:tada_client/service/common/styles/styles_service.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key, this.mainBloc}) : super(key: key);

  final MainBloc mainBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(LoginState()),
      child: _MainViewState(
        mainBloc: mainBloc,
      ),
    );
  }
}

class _MainViewState extends StatelessWidget {
  _MainViewState({Key key, this.mainBloc}) : super(key: key);

  final ImageService _image = Get.find();
  final StylesService _styles = Get.find();

  final MainBloc mainBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      builder: (context, state) {
        return Material(
          color: _styles.theme.backgroundColor,
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 42),
                _image.commonImage(ImageNames.logo),
                const Spacer(flex: 14),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF363762).withOpacity(0.18),
                        spreadRadius: 0,
                        blurRadius: 18,
                        offset: Offset(0, -1),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 4,
                          bottom: 21,
                        ),
                        child: Center(
                          child: Container(
                            height: 52,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 17,
                          top: 4,
                        ),
                        child: SizedBox(
                          height: 52,
                          child: TextField(
                            onChanged: (input) => context
                                .read<LoginBloc>()
                                .add(LoginChanged(input: input)),
                            decoration: InputDecoration(
                              counterText: '',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 17,
                                top: 14,
                                bottom: 14,
                              ),
                              hintText: 'Ваше имя',
                              hintStyle:
                                  _styles.theme.subhead1TextStyle.copyWith(
                                color: Color(0xFF9B9EA8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 52,
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(6),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      color: _styles.theme.accentColor,
                      onPressed: () {
                        context.read<LoginBloc>().add(Login());
                      },
                      child: Center(
                        child: Text(
                          'Войти',
                          style: _styles.theme.subhead1TextStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom == 0
                        ? 48
                        : MediaQuery.of(context).viewInsets.bottom + 8),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.loginSuccess) {
          mainBloc.add(LoginSuccess());
        }
      },
    );
  }
}
