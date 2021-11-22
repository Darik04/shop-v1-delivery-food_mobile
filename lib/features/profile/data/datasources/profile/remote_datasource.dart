
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shopv1deliveryfood_mobile/core/error/exceptions.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/endpoints.dart';

import '../../../../../locator.dart';

abstract class ProfileRemoteDataSource {
  Future<bool> updateUserInfo({required String firstName, required String lastName, required int cityId, File? avatar});
  Future<bool> sendCodeForChangePhone({required String newPhone});
  Future<bool> updatePhoneNumber({required int code});

}

class ProfileRemoteDataSourceImpl
    implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Token ${sl<AuthConfig>().token}"

  };


  ///Update user info
  @override
  Future<bool> updateUserInfo({required String firstName, required String lastName, required int cityId, File? avatar})async {

    var formData = FormData.fromMap({
      "first_name": firstName,
      "last_name": lastName,
      "city_id": cityId,
      "avatar": avatar != null && avatar.path != null? await MultipartFile.fromFile(avatar.path) : null,
    });
    Response response = await dio.put(Endpoints.updateUserInfo.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 401,
            headers: headers));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }


  ///send code for update phone number
  @override
  Future<bool> sendCodeForChangePhone({required String newPhone})async {

    var formData = FormData.fromMap({
      "new_phone": newPhone
    });
    Response response = await dio.post(Endpoints.sendCodeToUpdatePhone.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 401,
            headers: headers));
    if (response.statusCode == 200) {
      return true;
    } else if(response.statusCode == 400){
      throw ServerException(message: response.data['detail']);

    }
    else {
      throw ServerException();
    }
  }




  ///update phone user
  @override
  Future<bool> updatePhoneNumber({required int code})async {

    var formData = FormData.fromMap({
      "code": code
    });
    Response response = await dio.put(Endpoints.updatePhone.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 401,
            headers: headers));
    if (response.statusCode == 200) {
      return true;
    } else if(response.statusCode == 400){
      throw ServerException(message: response.data['detail']);

    }
    else {
      throw ServerException();
    }
  }






}
