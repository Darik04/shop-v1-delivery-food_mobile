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
  getProductsByCategoryId,

  //Favorite
  getFavoriteProducts,
  addToFavoriteProducts,
  deleteFavoriteProduct,


  //Profile
  updateUserInfo,
  sendCodeToUpdatePhone,
  updatePhone,


  //Cart
  getCartProducts,
  addToCart,
  deleteFromCart,
  clearCart,


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
        if(params!.length > 1)
          return "$url/all-products/?page=${params[0]}&sort_by=${params[1]}";
        return "$url/all-products/?page=${params[0]}";
      case Endpoints.getCategories:
        return "$url/categories/?limit=800";
      case Endpoints.getPromotions:
        return "$url/promotions/?page=${params![0]}";
      case Endpoints.updateUserInfo:
        return "$url/user-update/";
      case Endpoints.sendCodeToUpdatePhone:
        return "$url/send-code-for-update-phone/";
      case Endpoints.updatePhone:
        return "$url/phone-update/";
      case Endpoints.getProductsByCategoryId:
        return "$url/category-products/?category_id=${params![0]}&page=${params[1]}&sort_by=${params[2]}";
      case Endpoints.getFavoriteProducts:
        return "$url/favorite-products/?page=${params![0]}";
      case Endpoints.addToFavoriteProducts:
        return "$url/add-to-favorite/";
      case Endpoints.deleteFavoriteProduct:
        return "$url/delete-favorite-product/";
      case Endpoints.getCartProducts:
        return "$url/cart-products/?page=${params![0]}";
      case Endpoints.clearCart:
        return "$url/clear-cart/";
      case Endpoints.addToCart:
        return "$url/add-to-cart/";
      case Endpoints.deleteFromCart:
        return "$url/delete-cart-product/";
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

