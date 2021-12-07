enum Config { baseUrl, baseScheme, baseAPIpath, url }

const bool isDev = true;

// const String myUrl = '0.0.0.0';
const String myUrl = '192.168.1.119';

extension ConfigExtension on Config {
  String get value {
    switch (this) {
      case Config.baseUrl:
        return !isDev ? "REALURL" : myUrl;
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
