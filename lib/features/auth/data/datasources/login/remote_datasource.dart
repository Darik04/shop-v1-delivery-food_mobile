import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shopv1deliveryfood_mobile/core/error/exceptions.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/endpoints.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/data/models/token_model.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/data/models/user_model.dart';

import '../../../../../locator.dart';

abstract class AuthenticationRemoteDataSource {
  Future<String> sendSMS(String phone);
  Future<bool> register({required String phone, required String firstName, required String lastName, File? avatar, required int cityId});

  Future<TokenModel> authSignIn(String phone, String code);
  Future<UserModel> getUserInfo();

}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final Dio dio;

  AuthenticationRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  //Send sms code for check phone - login user
  @override
  Future<String> sendSMS(String phone) async {
    var formData = FormData.fromMap({"phone": phone});

    Response response = await dio.post(Endpoints.sendCode.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            // validateStatus: (status) => status! < 500,
            headers: headers));

    if (response.statusCode == 200) {
      return response.data['code'].toString();
    } else {
      throw ServerException();
    }
  }

  //Send sms code for check phone - login user
  @override
  Future<TokenModel> authSignIn(String phone, String code) async {
    int toIntcode = int.parse(code);
    var formData = FormData.fromMap({"phone": phone, "code": toIntcode});

    Response response = await dio.post(Endpoints.login.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 401,
            headers: headers));
    if (response.statusCode == 200) {
      return TokenModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  //Registration user - register user
  @override
  Future<bool> register({required String phone, required String firstName, required String lastName, File? avatar, required int cityId}) async {
    headers = {
      "Accept" : "application/json",
      "Content-Type": "multipart/form-data",
      "Authorization": "Token ${sl<AuthConfig>().token}"
    };
    var formData = FormData.fromMap({
      "phone": phone, 
      "first_name": firstName,
      "last_name": lastName,
      "city_id": cityId,
      "avatar": avatar != null && avatar.path != null? await MultipartFile.fromFile(avatar.path) : null,
    });

    Response response = await dio.post(Endpoints.register.getPath(),
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 401,
            headers: headers));
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return true;
    } else {
      throw ServerException();
    }
  }

  /// Get user info from back-end
  @override
  Future<UserModel> getUserInfo() async {
    print('GETTING USER INFO');
    String token = sl<AuthConfig>().token!;
    headers.addAll({"Authorization": "Token $token"});
    Response response = await dio.get(Endpoints.getUserInfo.getPath(),
        options: Options(
          headers: headers,
          validateStatus: (status) => status! < 501,
        ));
    print('GOT USER INFO: ${response.statusCode}');
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else if(response.statusCode == 401) {
      return UserModel(firstName: 'unauthorized', apartment: '', avatar: '', city: null, createdAt: DateTime.now(), entrance: '', homeNumber: '', id: 1, lastLogin: null, lastName: '', lat: null, long: null, phone: '', street: '', registered: true);
    } else {
      throw ServerException();
    }
  }




}
