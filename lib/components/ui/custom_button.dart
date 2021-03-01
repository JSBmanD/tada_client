import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tada_client/service/common/image/image_service.dart';

/// Кастомная кнопка
class CustomButton extends StatelessWidget {
  CustomButton({Key key, this.onTap, this.image, this.child}) : super(key: key);

  final ImageService _image = Get.find();

  /// Событие нажатия
  final Function onTap;

  /// Название картинки, если нет виджета
  final String image;

  /// Виджет
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      child: child ?? _image.commonImage(image),
    );
  }
}
