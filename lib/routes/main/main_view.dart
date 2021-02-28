import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tada_client/routes/main/main_bloc.dart';
import 'package:tada_client/service/ws/messaging/dto/SendMessageRequest.dart';
import 'package:tada_client/service/ws/ws_service.dart';

class MainView extends StatelessWidget {
  final WSService _websocket = Get.find();

  void closePage() {}

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      builder: (context, state) {
        return Container(
          child: CupertinoButton(
            onPressed: () {
              _websocket.sendMessage(SendMessageRequest(
                text: 'Test string',
                room: 'kozma',
              ));
            },
            child: Text('send'),
          ),
        );
      },
      listener: (context, state) {
        if (state.isLoggedIn) {}
      },
    );
  }
}
