import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

/// Базовый класс API клиента
class ApiClient {
  final Dio dio;

  ApiClient({@required this.dio}) : assert(dio != null) {
    init();
  }

  /// Базовая инициализация
  void init() {
    dio.options.baseUrl = 'https://nane.tada.team/api';
    dio.options.connectTimeout = 4000;
    dio.options.receiveTimeout = 5000;
  }

  /// Делает GET запрос и возвращает json
  Future<dynamic> get(String url) async {
    final response = await dio.get(url);

    return response;
  }
}
