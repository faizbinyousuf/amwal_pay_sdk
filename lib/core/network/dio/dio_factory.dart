import 'package:amwalpay/core/network/dio/dio_interceptors.dart';
import 'package:amwalpay/core/network/urls.dart';
import 'package:dio/dio.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppUrls.webhookUrl,
        receiveTimeout: const Duration(milliseconds: 15000),
        connectTimeout: const Duration(milliseconds: 15000),
        sendTimeout: const Duration(milliseconds: 15000),
        headers: {
          'authority': 'localhost',
          'accept': 'text/plain',
          'accept-language': 'en-US,en;q=0.9',
          'content-type': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll({AppInterceptors(dio)});
    return dio;
  }
}
