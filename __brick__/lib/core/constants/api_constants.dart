import '../config/environment_config.dart';

class ApiConstants {
  static String get baseUrl => EnvironmentConfig.baseUrl;
  static const String apiVersion = 'v1';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
