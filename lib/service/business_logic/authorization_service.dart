import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tada_client/service/common/storage/storage_service.dart';

/// Сервис авторизации
class AuthorizationService {
  StorageService _storage;

  AuthorizationService() {
    _storage = Get.find();
  }

  /// Проверка логина
  bool isLoggedIn() => _storage.userSettings.isLoggedIn();

  /// Выполняет запрос на авторизацию
  Future<void> auth({@required String name}) async {
    _storage.userSettings.name = name;
  }

  /// Логаут юзера
  Future<bool> logout() async {
    _storage.userSettings.clearData();
    return true;
  }
}
