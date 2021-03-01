import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tada_client/service/common/image/image_service.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key key, this.onTap, this.image, this.child}) : super(key: key);

  final ImageService _image = Get.find();

  final Function onTap;
  final String image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      child: child ?? _image.commonImage(image),
    );
  }
}
