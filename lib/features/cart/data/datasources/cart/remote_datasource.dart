import 'package:dio/dio.dart';
import 'package:shopv1deliveryfood_mobile/core/error/exceptions.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/endpoints.dart';
import 'package:shopv1deliveryfood_mobile/features/home/data/models/product_model.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/data/models/pagination_model.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';

import '../../../../../locator.dart';

abstract class CartRemoteDataSource {
  ///-- Get cart products --
  Future<PaginaitonEntity> getCartProducts(int page);

  ///-- Add to cart --
  Future<bool> addToCart(int productId);

  ///-- Delete from cart --
  Future<bool> deleteFromCart(int productId);

  ///-- Clear cart --
  Future<bool> clearCart();

}

class CartRemoteDataSourceImpl
    implements CartRemoteDataSource {
  final Dio dio;

  CartRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Token ${sl<AuthConfig>().token}"
  };


  @override
  Future<PaginaitonEntity> getCartProducts(int page) async {

    Response response = await dio.get(Endpoints.getCartProducts.getPath(params: [page]),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    if (response.statusCode == 200) {
      List<ProductEntity> items = (response.data['results'] as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
      PaginaitonEntity paginaiton = PaginationModel.fromJson(response.data);

      paginaiton.results = items;
      return paginaiton;
    } else if(response.statusCode == 400){
      throw ServerException(message: response.data['detail']);
    } else if(response.statusCode == 404){
      return PaginaitonEntity(results: [], prevUrl: null, nextUrl: null);
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }







  ///Clear cart
  @override
  Future<bool> clearCart() async {
    Response response = await dio.delete(Endpoints.clearCart.getPath(),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers,));

    if (response.statusCode == 200) {
      return false;
    } else if(response.statusCode == 400){
      throw ServerException(message: response.data['detail']);
    }else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }









  @override
  Future<bool> addToCart(int productId) async {
    FormData formData = FormData.fromMap({
      'product_id': productId
    });
    Response response = await dio.post(Endpoints.addToCart.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers,));

    if (response.statusCode == 200) {
      return true;
    } else if(response.statusCode == 400){
      throw ServerException(message: response.data['detail']);
    }else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }










  @override
  Future<bool> deleteFromCart(int productId) async {
    FormData formData = FormData.fromMap({
      'product_id': productId
    });
    Response response = await dio.delete(Endpoints.deleteFromCart.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers,));

    if (response.statusCode == 200) {
      return true;
    } else if(response.statusCode == 400){
      throw ServerException(message: response.data['detail']);
    }else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }


  





}
