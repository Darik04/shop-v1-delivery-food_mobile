enum Config { baseUrl, baseScheme, baseAPIpath, url }

const bool isDev = true;

extension ConfigExtension on Config {
  String get value {
    switch (this) {
      case Config.baseUrl:
        return !isDev ? "REALURL" : '0.0.0.0';
      case Config.baseAPIpath:
        return 'api/v1';
      case Config.url:
        return url;
      default:
        return 'http';
    }
  }

  String get url {
    return Config.baseScheme.value +
        "://" +
        Config.baseUrl.value +
        '/' +
        Config.baseAPIpath.value;
  }

  String get urlWithoutApi {
    return Config.baseScheme.value +
        "://" +
        Config.baseUrl.value;
  }
}
