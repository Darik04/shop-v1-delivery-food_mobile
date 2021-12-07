import 'package:dio/dio.dart';
import 'package:shopv1deliveryfood_mobile/core/error/exceptions.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/endpoints.dart';
import 'package:shopv1deliveryfood_mobile/features/home/data/models/product_model.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/data/models/pagination_model.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';

import '../../../../../locator.dart';

abstract class FavoriteProductsRemoteDataSource {
  Future<PaginaitonEntity> getFavoriteProducts(int page);
  Future<bool> addToFavorite(int productId);
  Future<bool> deleteInFavoriteProduct(int productId);

}

class FavoriteProductsRemoteDataSourceImpl
    implements FavoriteProductsRemoteDataSource {
  final Dio dio;

  FavoriteProductsRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Token ${sl<AuthConfig>().token}"
  };


  //Get product 
  @override
  Future<PaginaitonEntity> getFavoriteProducts(int page) async {

    Response response = await dio.get(Endpoints.getFavoriteProducts.getPath(params: [page]),
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







  ///Add to favorites 
  @override
  Future<bool> deleteInFavoriteProduct(int productId) async {
    FormData formData = FormData.fromMap({
      'product_id': productId
    });
    Response response = await dio.delete(Endpoints.deleteFavoriteProduct.getPath(),
        data: formData,
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









  ///Add to favorites 
  @override
  Future<bool> addToFavorite(int productId) async {
    FormData formData = FormData.fromMap({
      'product_id': productId
    });
    Response response = await dio.post(Endpoints.addToFavoriteProducts.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers,));

    if (response.statusCode == 201) {
      return true;
    } else if(response.statusCode == 400){
      throw ServerException(message: response.data['detail']);
    }else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }


  





}
