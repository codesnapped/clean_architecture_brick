enum Environment { dev, stage, prod }

class EnvironmentConfig {
  static Environment _environment = Environment.dev;
  static Environment get environment => _environment;
  static void setEnvironment(Environment env) => _environment = env;
  static bool get isDev => _environment == Environment.dev;
  static bool get isStage => _environment == Environment.stage;
  static bool get isProd => _environment == Environment.prod;

  static String get environmentName {
    switch (_environment) {
      case Environment.dev: return 'Development';
      case Environment.stage: return 'Staging';
      case Environment.prod: return 'Production';
    }
  }

  static String get baseUrl {
    switch (_environment) {
      case Environment.dev: return '{{base_url_dev}}';
      case Environment.stage: return '{{base_url_stage}}';
      case Environment.prod: return '{{base_url_prod}}';
    }
  }
}
