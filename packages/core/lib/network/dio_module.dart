import 'package:core/config/build_config.dart';
import 'package:core/network/retry_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

const _connectTimeout = Duration(seconds: 10);
const _receiveTimeout = Duration(seconds: 15);

@module
abstract class DioModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: apiBaseUrl,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
      ),
    );
    dio.interceptors.add(RetryInterceptor(dio));
    return dio;
  }
}
