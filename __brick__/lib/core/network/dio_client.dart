import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';
import '../constants/api_constants.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );
    dio.interceptors.addAll([
      LogInterceptor(request: true, requestHeader: true, requestBody: true, responseHeader: true, responseBody: true, error: true),
      _AnalyticsInterceptor(),
    ]);
    return dio;
  }
}

class _AnalyticsInterceptor extends Interceptor {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _analytics.logEvent(name: 'api_request', parameters: {'method': options.method, 'path': options.path});
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _analytics.logEvent(name: 'api_error', parameters: {
      'method': err.requestOptions.method,
      'path': err.requestOptions.path,
      'status_code': err.response?.statusCode ?? 0,
      'error_type': err.type.toString(),
    });
    super.onError(err, handler);
  }
}
