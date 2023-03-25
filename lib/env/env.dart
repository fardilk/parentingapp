enum Environment { DEV, STAGING, PROD }

class Constants {
  static Map<String, dynamic> _config = _Config.debugConstants;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.STAGING:
        _config = _Config.qaConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static String get baseApi {
    return _config[_Config.BASE_API];
  }

  static String get baseAuthApi {
    return _config[_Config.BASE_AUTH_API];
  }

  static String get baseWeb {
    return _config[_Config.BASE_WEB];
  }
}

class _Config {
  static const BASE_API = "BASE_API";
  static const BASE_AUTH_API = "BASE_AUTH_API";
  static const BASE_WEB = "BASE_WEB";

  static Map<String, String> debugConstants = {
    BASE_API: "https://devapi.grouu.co.id/api/",
    BASE_AUTH_API: "https://dev-grouu-auth-service.grouu.id/api/",
    BASE_WEB: "https://fe-dev01.grouu.id/",
  };

  static Map<String, String> qaConstants = {
    BASE_API: "https://api.grouu.co.id/api/",
    BASE_AUTH_API: "https://dev-grouu-auth-service.grouu.id/api/",
    BASE_WEB: "https://www.grouu.id/",
  };

  static Map<String, String> prodConstants = {
    BASE_API: "https://api.grouu.co.id/api/",
    BASE_AUTH_API:
        "https://prod-grouu-auth-service.grouu.id/api/", //TODO: Waiting for production endpoint
    BASE_WEB: "https://www.grouu.id/",
  };
}
