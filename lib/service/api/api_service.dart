import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tada_client/service/api/api_client.dart';
import 'package:tada_client/service/api/messaging/api_messaging.dart';

/// Реализует доступ к ендпоинтам API
class ApiService {
  ApiClient _client;

  ApiMessaging _messaging;

  ApiService() {
    final dio = new Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    _client = ApiClient(dio: dio);

    _messaging = ApiMessaging(client: _client);
  }

  ApiMessaging getMessagingClient() => _messaging;
}
