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
import 'package:shopv1deliveryfood_mobile/features/promotions/data/models/promotion_model.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/entities/promotion_entity.dart';

import '../../../../../locator.dart';

abstract class PromotionsRemoteDataSource {
  Future<List<PromotionEntity>> getPromotions(int page);

}

class PromotionsRemoteDataSourceImpl
    implements PromotionsRemoteDataSource {
  final Dio dio;

  PromotionsRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };


  //Get promotions with pagination
  @override
  Future<List<PromotionEntity>> getPromotions(int page) async {

    Response response = await dio.get(Endpoints.getPromotions.getPath(params: [page]),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    if (response.statusCode == 200) {
      List<PromotionModel> promos = (response.data['results'] as List)
            .map((json) => PromotionModel.fromJson(json))
            .toList();

      return promos;
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }






}
