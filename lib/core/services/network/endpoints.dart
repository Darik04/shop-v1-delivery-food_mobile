import 'config.dart';
import 'dart:core';

enum Endpoints {
  // Authentication
  sendCode,
  login,
  register,
  getUserInfo,

  //Cities
  getCities,

  //Home
  getHomeProducts,
  getCategories,

  getPromotions,


  //Profile
  updateUserInfo,
  sendCodeToUpdatePhone,
  updatePhone


}

extension EndpointsExtension on Endpoints {
  String getPath({
    List<dynamic>? params,
  }) {
    var url = Config.url.url;
    switch (this) {
      case Endpoints.sendCode:
        return "$url/send-code/";
      case Endpoints.login:
        return "$url/login/";
      case Endpoints.register:
        return "$url/register/";
      case Endpoints.getUserInfo:
        return "$url/get-user-info/";
      case Endpoints.getCities:
        return "$url/get-cities/";
      case Endpoints.getHomeProducts:
        return "$url/all-products/?page=${params![0]}";
      case Endpoints.getCategories:
        return "$url/categories/?limit=56";
      case Endpoints.getPromotions:
        return "$url/promotions/?page=${params![0]}";
      case Endpoints.updateUserInfo:
        return "$url/user-update/";
      case Endpoints.sendCodeToUpdatePhone:
        return "$url/send-code-for-update-phone/";
      case Endpoints.updatePhone:
        return "$url/phone-update/";
      default:
        return '';
    }
  }

  String get hostName {
    return Config.baseUrl.value;
  }

  String get scheme {
    return Config.baseScheme.value;
  }

  String get path {
    return Config.baseAPIpath.value;
  }

  Map<String, String> getHeaders(
      {String token = '', required Map<String, String> defaultHeaders}) {
    return {
      if (defaultHeaders != null) ...defaultHeaders,
      if (defaultHeaders == null) ...{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      if (token != '') ...{'Authorization': 'Token $token'}
    };
  }

  Uri buildURL(
      {Map<String, dynamic>? queryParameters, List<dynamic>? urlParams}) {
    var url = Uri(
        scheme: this.scheme,
        host: this.hostName,
        path: this.getPath(params: urlParams),
        queryParameters: queryParameters ?? {});
    return url;
  }
}

