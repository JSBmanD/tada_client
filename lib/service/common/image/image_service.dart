import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tada_client/helpers/image_helper.dart';

class ImageService {
  /// Получить изображение универсальное к локализации
  Image commonImage(String name) => ImageHelper.commonImage(name);

  /// Получить изображение универсальное к локализации с цветом
  Image commonColoredImage(String name, {Color color = Colors.white}) =>
      ImageHelper.commonColoredImage(name, color);
}
