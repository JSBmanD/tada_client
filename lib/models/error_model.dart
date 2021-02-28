import 'package:flutter/material.dart';

/// Тип ошибки
enum ErrorType { DIALOG, LOG_ONLY }

/// Приоритет ошибки
enum ErrorPriority { CRITICAL, WARNING, MINOR, INFO }

/// Модель ошибки
class ErrorModel implements Exception {
  ErrorModel({
    @required this.message,
    this.exception,
    this.type = ErrorType.DIALOG,
    this.priority = ErrorPriority.MINOR,
    this.callback,
  });

  /// Текст ошибки
  final String message;

  /// Объект ошибки
  final dynamic exception;

  /// Тип ошибки
  final ErrorType type;

  /// Приоритет ошибки
  final ErrorPriority priority;

  /// Коллбэк
  final Function callback;
}
