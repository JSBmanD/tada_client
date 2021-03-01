/// Хелпер для обработки текста
class RegexHelper {
  /// Убрать пробелы в начале и конце
  static String removeUnneededSpaces(String input) {
    return input?.trim() ?? '';
  }
}
