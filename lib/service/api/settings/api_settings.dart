import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tada_client/models/domain/Settings.dart';
import 'package:tada_client/service/api/api_client.dart';
import 'package:tada_client/service/api/settings/dto/SettingsDto.dart';

/// Эндпоинты для настроек
class ApiSettings {
  final ApiClient client;

  ApiSettings({@required this.client}) : assert(client != null);

  /// Получает настройки
  Future<Settings> getSettings() async {
    final response = await client.get('/settings');
    if (response.statusCode != 200)
      throw DioError(
        type: DioErrorType.RESPONSE,
        error: 'System error',
        response: Response(statusCode: response.statusCode),
      );
    final parsed = SettingsDto.fromJson(response.data).result;

    final result = Settings(
      maxMessageLength: parsed.maxMessageLength,
      maxRoomTitleLength: parsed.maxRoomTitleLength,
      maxUsernameLength: parsed.maxUsernameLength,
      uptime: parsed.uptime,
    );

    return result;
  }
}
