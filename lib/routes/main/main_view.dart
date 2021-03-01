import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada_client/components/ui/room_item.dart';
import 'package:tada_client/routes/main/main_bloc.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
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
                            context
                                .read<MainBloc>()
                                .add(OpenRoom(roomId: room.name));
                          },
                          name: room.name,
                          lastMessage: room.lastMessage,
                        ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
