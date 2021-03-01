import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tada_client/components/ui/custom_button.dart';
import 'package:tada_client/components/ui/custom_list_builder.dart';
import 'package:tada_client/components/ui/custom_text_field.dart';
import 'package:tada_client/components/ui/message_item.dart';
import 'package:tada_client/helpers/image_names.dart';
import 'package:tada_client/routes/main/main_bloc.dart';
import 'package:tada_client/routes/room/room_bloc.dart';
import 'package:tada_client/service/common/image/image_service.dart';
import 'package:tada_client/service/common/styles/styles_service.dart';

class RoomView extends StatelessWidget {
  const RoomView({Key key, this.roomId, this.mainBloc}) : super(key: key);

  final String roomId;
  final MainBloc mainBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomBloc(RoomState())..add(InitRoom(roomId)),
      child: _RoomViewState(mainBloc: mainBloc),
    );
  }
}

class _RoomViewState extends StatelessWidget {
  _RoomViewState({Key key, this.mainBloc}) : super(key: key);

  final StylesService _styles = Get.find();
  final ImageService _image = Get.find();

  final MainBloc mainBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomBloc, RoomState>(
      builder: (context, state) {
        return Material(
          color: _styles.theme.backgroundColor,
          child: SafeArea(
            child: Stack(
              children: [
                CustomListBuilder(
                  items: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 60,
                      ),
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
                  top: 0,
                  height: 60,
                  child: Container(
                    color: _styles.theme.backgroundColor,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(
                              onTap: () {
                                mainBloc.add(ClosePage());
                              },
                              image: ImageNames.back,
                            ),
                            Expanded(
                              child: Text(
                                state.roomId ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: _styles.theme.headline1TextStyle,
                              ),
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
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0 + MediaQuery.of(context).viewInsets.bottom,
                  height: 60,
                  child: Container(
                    color: _styles.theme.backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              onChanged: (value) {
                                context
                                    .read<RoomBloc>()
                                    .add(CommentChanged(value: value));
                              },
                              controller: state.textController,
                            ),
                          ),
                          CustomButton(
                            onTap: () {
                              context.read<RoomBloc>().add(SendMessage());
                            },
                            child: Text('Отправить'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                state.messages == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
