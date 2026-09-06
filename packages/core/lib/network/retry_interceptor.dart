import 'package:dio/dio.dart';

const _retryDelays = [Duration(milliseconds: 300), Duration(milliseconds: 900)];
const _retriableStatusCodes = {502, 503, 504};
const _attemptKey = "retryAttempt";

// * the book catalogue answers a noticeable share of requests with a transient 5xx that succeeds
// * on the very next try, so one failed response must not reach the user as an error
class const RetryInterceptor(
  final Dio _dio,
) extends Interceptor {
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final attempt = (err.requestOptions.extra[_attemptKey] as int?) ?? 0;
    if (attempt >= _retryDelays.length || !_isRetriable(err)) {
      handler.next(err);
      return;
    }
    await Future<void>.delayed(_retryDelays[attempt]);
    final options = err.requestOptions..extra[_attemptKey] = attempt + 1;
    try {
      handler.resolve(await _dio.fetch<dynamic>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }
}

bool _isRetriable(DioException error) => switch (error.type) {
  DioExceptionType.connectionTimeout ||
  DioExceptionType.receiveTimeout ||
  DioExceptionType.sendTimeout ||
  DioExceptionType.connectionError => true,
  DioExceptionType.badResponse => _retriableStatusCodes.contains(error.response?.statusCode),
  _ => false,
};
