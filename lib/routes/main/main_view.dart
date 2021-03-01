import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tada_client/components/ui/custom_button.dart';
import 'package:tada_client/components/ui/custom_text_field.dart';
import 'package:tada_client/components/ui/room_item.dart';
import 'package:tada_client/helpers/image_names.dart';
import 'package:tada_client/routes/main/main_bloc.dart';
import 'package:tada_client/service/common/connectivity/connectivity_service.dart';
import 'package:tada_client/service/common/styles/styles_service.dart';

class MainView extends StatelessWidget {
  final StylesService _styles = Get.find();
  final ConnectivityService _connect = Get.find();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Material(
          color: _styles.theme.backgroundColor,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 86),
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
                  Container(
                    height: 70,
                    color: _styles.theme.backgroundColor,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Чаты',
                              style: _styles.theme.headline1TextStyle,
                            ),
                            const Spacer(),
                            CustomButton(
                              onTap: () {
                                context.read<MainBloc>().add(Logout());
                              },
                              image: ImageNames.logout,
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Divider(
                          height: 2,
                          thickness: 2,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 16,
                    height: 60,
                    width: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      alignment: const Alignment(0, -0.2),
                      child: CustomButton(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (innerContext) {
                                return Container(
                                  height: 300,
                                  color: _styles.theme.accentColor,
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Создать чат',
                                        style: _styles.theme.subhead1TextStyle
                                            .copyWith(
                                          color: _styles.theme.backgroundColor,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Название комнаты',
                                        style: _styles.theme.body2TextStyle
                                            .copyWith(
                                          color: _styles.theme.backgroundColor,
                                        ),
                                      ),
                                      CustomTextField(
                                        onChanged: (value) {
                                          context.read<MainBloc>().add(
                                              RoomNameChanged(value: value));
                                        },
                                        controller: state.roomNameController,
                                      ),
                                      const SizedBox(height: 24),
                                      Text(
                                        'Первое сообщение',
                                        style: _styles.theme.body2TextStyle
                                            .copyWith(
                                          color: _styles.theme.backgroundColor,
                                        ),
                                      ),
                                      CustomTextField(
                                        onChanged: (value) {
                                          context.read<MainBloc>().add(
                                              FirstMessageChanged(
                                                  value: value));
                                        },
                                        controller:
                                            state.firstMessageController,
                                      ),
                                      CustomButton(
                                        onTap: () {
                                          if (state.firstMessageController.text
                                                  .isNotEmpty &&
                                              state.roomNameController.text
                                                  .isNotEmpty &&
                                              _connect.isConnectedToInternet) {
                                            Navigator.of(innerContext).pop();
                                          }
                                          context
                                              .read<MainBloc>()
                                              .add(CreateRoom());
                                        },
                                        child: Text(
                                          'Создать и отправить',
                                          style: _styles.theme.subhead2TextStyle
                                              .copyWith(
                                            color:
                                                _styles.theme.backgroundColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).then((value) {
                            context.read<MainBloc>().add(ClearFields());
                          });
                        },
                        child: Icon(Icons.edit),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
