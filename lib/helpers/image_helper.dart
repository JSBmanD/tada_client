import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Хелпер для получения изображений
class ImageHelper {
  // Путь до папки с изображениями
  static const String _pathToImageAssets = 'assets/img';

  /// Получить языконезависимую картинку
  static Image commonImage(String name) {
    return Image(image: AssetImage('$_pathToImageAssets/$name.png'));
  }

  /// Получить языконезависимую картинку с цветом
  static Image commonColoredImage(String name, Color color) {
    return Image(
      image: AssetImage('$_pathToImageAssets/$name.png'),
      color: color,
    );
  }
}
