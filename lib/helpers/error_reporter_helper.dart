import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tada_client/models/error_model.dart';

class ErrorReporterHelper {
  static final _logger = Logger();

  /// Репортнуть критическую ошибку
  static void reportCritical(ErrorModel error) {
    _logger.e(error.message, error.exception);

    showError(
        message: error.message, callback: error.callback, type: error.type);
  }

  /// Репортнуть предупреждение
  static void reportWarning(ErrorModel error) {
    _logger.w(error.message, error.exception);

    showError(
        message: error.message, callback: error.callback, type: error.type);
  }

  /// Репортнуть минорную ошибку
  static void reportMinor(ErrorModel error) {
    _logger.i(error.message, error.exception);

    showError(
        message: error.message, callback: error.callback, type: error.type);
  }

  /// Репорт инфо сбщ
  static void reportInfo(ErrorModel error) {
    _logger.i(error.message, error.exception);

    showError(
        message: error.message,
        callback: error.callback,
        type: error.type,
        title: '');
  }

  static void showError({
    @required String message,
    Function callback,
    ErrorType type = ErrorType.DIALOG,
    String title = 'Ошибка',
  }) {
    switch (type) {
      case ErrorType.DIALOG:
        Get.defaultDialog(
          title: 'Ошибка',
          middleText: message,
        );
        break;
      default:
        _logger.w('Ошибка: $message');
        break;
    }
  }
}
