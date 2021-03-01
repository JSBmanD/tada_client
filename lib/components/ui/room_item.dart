import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tada_client/models/domain/Message.dart';
import 'package:tada_client/service/common/styles/styles_service.dart';

/// Виджет комнаты
class RoomItem extends StatelessWidget {
  RoomItem({Key key, this.name, this.lastMessage, this.onTap})
      : super(key: key);

  final StylesService _styles = Get.find();

  /// Название
  final String name;

  /// Последнее сообщение
  final Message lastMessage;

  /// Коллбэк
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    String userName = lastMessage.sender.username;
    if (userName.contains(':443/?')) {
      userName = userName.substring(0, userName.length - 6);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: _styles.theme.backgroundColor,
        width: double.infinity,
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
                style: _styles.theme.subhead1TextStyle
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: RichText(
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: userName + ': ',
                  style: _styles.theme.subhead2TextStyle
                      .copyWith(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: lastMessage.text,
                      style: _styles.theme.subhead2TextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
