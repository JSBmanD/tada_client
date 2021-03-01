import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tada_client/routes/login/login_view.dart';
import 'package:tada_client/routes/main/main_bloc.dart';
import 'package:tada_client/routes/main/main_view.dart';
import 'package:tada_client/routes/room/room_view.dart';
import 'package:tada_client/service/common/styles/styles_service.dart';

class MainTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(MainState())..add(InitAuth()),
      child: _MainViewState(),
    );
  }
}

class _MainViewState extends StatefulWidget {
  @override
  __MainViewStateState createState() => __MainViewStateState();
}

class __MainViewStateState extends State<_MainViewState>
    with SingleTickerProviderStateMixin {
  final StylesService _styles = Get.find();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            WillPopScope(
              onWillPop: () async {
                context.read<MainBloc>().add(ClosePage());
                return false;
              },
              child: Scaffold(
                backgroundColor: _styles.theme.backgroundColor,
                extendBodyBehindAppBar: true,
                body: Navigator(
                  pages: [
                    if (!state.isLoggedIn)
                      MaterialPage(
                        child: LoginView(
                          mainBloc: BlocProvider.of<MainBloc>(context),
                        ),
                      ),
                    if (state.isLoggedIn)
                      MaterialPage(
                        child: MainView(),
                      ),
                    if (state.roomId != null && state.roomId.isNotEmpty)
                      MaterialPage(
                        child: RoomView(
                          roomId: state.roomId,
                          mainBloc: BlocProvider.of<MainBloc>(context),
                        ),
                      ),
                  ],
                  onPopPage: (route, result) {
                    if (!route.didPop(result)) return false;

                    context.read<MainBloc>().add(ClosePage());

                    return true;
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
