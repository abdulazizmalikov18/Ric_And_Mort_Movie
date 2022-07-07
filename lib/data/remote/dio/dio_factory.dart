import 'package:dio/dio.dart';
import 'package:ric_and_mort_movie/data/remote/dio/logging_interceptor.dart';

class DioFactory {
  final String _baseUrl;

  DioFactory(this._baseUrl);

  BaseOptions _createBaseOptions() => BaseOptions(
        baseUrl: _baseUrl,
        receiveTimeout: 5000,
        sendTimeout: 5000,
        connectTimeout: 5000,
      );

  Dio create() => Dio(_createBaseOptions())
    ..interceptors.addAll([
      LoggerInterceptor(),
    ]);
}
