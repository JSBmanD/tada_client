import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tada_client/models/domain/Message.dart';
import 'package:tada_client/service/common/styles/styles_service.dart';

class RoomItem extends StatelessWidget {
  final StylesService _styles = Get.find();

  RoomItem({Key key, this.name, this.lastMessage, this.onTap})
      : super(key: key);

  final String name;
  final Message lastMessage;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              name,
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: _styles.theme.headline1TextStyle
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: RichText(
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: lastMessage.sender.username + ': ',
                style: _styles.theme.subhead1TextStyle
                    .copyWith(fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: lastMessage.text,
                    style: _styles.theme.subhead1TextStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
