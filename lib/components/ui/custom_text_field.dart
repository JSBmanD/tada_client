import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Кастомное поле ввода
class CustomTextField extends StatelessWidget {
  const CustomTextField({Key key, this.controller, this.onChanged})
      : super(key: key);

  /// Контроллер
  final TextEditingController controller;

  /// Коллбэк
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
