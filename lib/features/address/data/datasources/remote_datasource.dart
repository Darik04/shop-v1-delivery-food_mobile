import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shopv1deliveryfood_mobile/core/error/exceptions.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/endpoints.dart';
import 'package:shopv1deliveryfood_mobile/features/address/data/models/city_model.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/data/models/token_model.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/data/models/user_model.dart';

import '../../../../../locator.dart';

abstract class CityRemoteDataSource {
  Future<List<CityModel>> getAllCities();

}

class CityRemoteDataSourceImpl
    implements CityRemoteDataSource {
  final Dio dio;

  CityRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
  };



  @override
  Future<List<CityModel>> getAllCities() async {

    Response response = await dio.get(Endpoints.getCities.getPath(),
        options: Options(
            validateStatus: (status) => status! < 499,
            headers: headers));
    if (response.statusCode == 200) {
      return (response.data['results'] as List)
              .map((i) => CityModel.fromJson(i))
              .toList();
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }




}
