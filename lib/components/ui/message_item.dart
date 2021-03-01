import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tada_client/models/domain/Message.dart';
import 'package:tada_client/service/common/styles/styles_service.dart';

class MessageItem extends StatelessWidget {
  final StylesService _styles = Get.find();

  MessageItem({Key key, this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.sender.username,
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _styles.theme.headline1TextStyle
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            message.text,
            style: _styles.theme.subhead1TextStyle
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
