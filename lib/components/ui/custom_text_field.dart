import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key key, this.controller, this.onChanged})
      : super(key: key);

  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller ?? TextEditingController(),
      onChanged: onChanged,
      maxLines: 1,
    );
  }
}
