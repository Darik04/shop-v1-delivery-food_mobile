import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shopv1deliveryfood_mobile/core/error/exceptions.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/endpoints.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/data/models/token_model.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/data/models/user_model.dart';
import 'package:shopv1deliveryfood_mobile/features/home/data/models/category_model.dart';
import 'package:shopv1deliveryfood_mobile/features/home/data/models/product_model.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/category_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';

import '../../../../../locator.dart';

abstract class HomeRemoteDataSource {
  Future<List<ProductEntity>> getHomeProducts(int page);
  Future<List<CategoryEntity>> getCategories();

}

class HomeRemoteDataSourceImpl
    implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };


  //Get products for home view with pagination system
  @override
  Future<List<ProductEntity>> getHomeProducts(int page) async {
    
    if(sl<AuthConfig>().token != null){
      headers.addAll({"Authorization": "Token ${sl<AuthConfig>().token}"});
    }
    
    Response response = await dio.get(Endpoints.getHomeProducts.getPath(params: [page]),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    if (response.statusCode == 200) {
      // print('RESPONSE: ${response.data}');
      List<ProductModel> products = (response.data['results'] as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
      // print('RESULT: ${products}');

      return products;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }



  //Get categories for home view 
  @override
  Future<List<CategoryEntity>> getCategories() async {

    Response response = await dio.get(Endpoints.getCategories.getPath(),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));

    if (response.statusCode == 200) {
      List<CategoryModel> categories = (response.data['results'] as List)
            .map((json) => CategoryModel.fromJson(json))
            .toList();
      return categories;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }


}
