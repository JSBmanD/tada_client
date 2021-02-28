import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tada_client/models/error_model.dart';
import 'package:tada_client/service/common/log/error_service.dart';
import 'package:tada_client/service/common/storage/storage_service.dart';

/// Базовый класс API клиента
class ApiClient {
  final Dio dio;
  final List<int> _successfulStatusCodes = [200, 204];
  final Map<String, String> _headers = Map<String, String>();
  StorageService _storage;
  ErrorService _errors;

  ApiClient({@required this.dio}) : assert(dio != null) {
    _storage = Get.find();
    _errors = Get.find();
    init();
  }

  /// Базовая инициализация
  void init() {
    dio.options.baseUrl = 'https://nane.tada.team/api';
    dio.options.connectTimeout = 4000;
    dio.options.receiveTimeout = 5000;
    //_setBaseHeaders();
  }

  /// Проверяет статус ответа, пришедшего от сервера
  void _checkStatusCode(int code) {
    if (!_successfulStatusCodes.contains(code)) {
      if (code == 401 || code == 403) {
        _storage.userSettings.clearData();
        init();
        _errors.addError(
          ErrorModel(
            message: 'Токен авторизации истек',
            type: ErrorType.DIALOG,
          ),
        );
      } else {
        if (code > 299) {
          _errors.addError(
            ErrorModel(
              message: 'Внутренняя ошибка сервера (код статуса $code)',
              type: ErrorType.DIALOG,
            ),
          );
        }
      }
    }
  }

  /// Добавляет заголовок
  void addOrUpdateHeader(String name, String value) {
    if (_headers.containsKey(name)) {
      _headers[name] = value;
    } else {
      _headers.putIfAbsent(name, () => value);
    }
    dio.options.headers = _headers;
  }

  /// Очистка заголовков
  void clearHeaders() {
    _headers.clear();
    dio.options.headers = _headers;
    _setBaseHeaders();
  }

  /// Делает GET запрос и возвращает json
  Future<dynamic> get(String url) async {
    final response = await dio.get(url);
    _checkStatusCode(response.statusCode);

    return response;
  }

  Future<void> ping() async {
    await dio.get('/../ping',
        options: Options(sendTimeout: 2500, receiveTimeout: 2500));
  }

  void _setBaseHeaders() {
    addOrUpdateHeader('accept', 'application/json');
  }
}
