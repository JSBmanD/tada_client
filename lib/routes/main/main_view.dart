import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tada_client/components/ui/room_item.dart';
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
        return Material(
          color: Colors.white,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    if (state.rooms != null && state.rooms.length > 0)
                      for (var room in state.rooms)
                        RoomItem(
                          onTap: () {
                            // TODO: Сделать событие на тап
                          },
                          name: room.name,
                          lastMessage: room.lastMessage,
                        ),
                    Container(
                      child: CupertinoButton(
                        onPressed: () {
                          _websocket.sendMessage(SendMessageRequest(
                            text: 'Test string',
                            room: 'kozma',
                          ));
                        },
                        child: Text('send'),
                      ),
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.isLoggedIn) {}
      },
    );
  }
}
