import 'package:tada_client/models/common/themes/base_theme.dart';
import 'package:tada_client/models/common/themes/light_theme.dart';

class StylesService {
  String themeType;
  BaseTheme theme;

  // Инициализация
  Future<void> init() async {
    theme = LightTheme();
  }
}
