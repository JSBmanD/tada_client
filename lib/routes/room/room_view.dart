import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tada_client/components/ui/custom_list_builder.dart';
import 'package:tada_client/components/ui/message_item.dart';
import 'package:tada_client/routes/room/room_bloc.dart';
import 'package:tada_client/service/ws/ws_service.dart';

class RoomView extends StatelessWidget {
  const RoomView({Key key, this.roomId}) : super(key: key);

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomBloc(RoomState())..add(InitRoom(roomId)),
      child: _RoomViewState(),
    );
  }
}

class _RoomViewState extends StatelessWidget {
  final WSService _websocket = Get.find();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomBloc, RoomState>(
      builder: (context, state) {
        return Material(
          color: Colors.white,
          child: SafeArea(
            child: Stack(
              children: [
                CustomListBuilder(
                  items: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          if (state.messages != null &&
                              state.messages.length > 0)
                            for (var message in state.messages)
                              MessageItem(
                                message: message,
                              ),
                          const SizedBox(height: 64),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0 + MediaQuery.of(context).viewInsets.bottom,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: state.textController,
                            maxLines: 1,
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () {
                            context.read<RoomBloc>().add(SendMessage());
                          },
                          child: Text('Send'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
