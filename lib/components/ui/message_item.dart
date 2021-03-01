import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_client/models/domain/Message.dart';
import 'package:tada_client/service/common/styles/styles_service.dart';

class MessageItem extends StatelessWidget {
  final StylesService _styles = Get.find();

  MessageItem({Key key, this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    // Штука странная, но плагин добавляет эту строку при отправке, так что стоит переписать сервис на другом клиенте
    String userName = message.sender.username;
    if (userName.contains(':443/?')) {
      userName = userName.substring(0, userName.length - 6);
    }
    return Container(
      color: _styles.theme.backgroundColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
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
