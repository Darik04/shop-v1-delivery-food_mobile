
import 'package:shopv1deliveryfood_mobile/features/address/data/models/city_model.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({
    required int id,
    required String firstName,
    required String lastName,
    required String phone,
    required String avatar,
    required bool registered,

    
    required CityModel? city,
    required String? street,
    required String? homeNumber,
    required String? entrance,
    required String? apartment,
    required double? lat,
    required double? long,


    required DateTime createdAt,
    required DateTime? lastLogin,

  }) : super(
    id: id, 
    firstName: firstName, 
    lastName: lastName, 
    phone: phone,
    avatar: avatar,
    registered: registered,

    city: city,
    street: street,
    homeNumber: homeNumber,
    entrance: entrance,
    apartment: apartment,
    lat: lat,
    long: long,

    createdAt: createdAt,
    lastLogin: lastLogin
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    firstName: json['username'],
    lastName: json['last_name'],
    phone: json['phone'],
    registered: json['registered'],
    avatar: json['avatar'] == false ? null : json['avatar'],


    city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
    street: json['street'],
    homeNumber: json['home_number'],
    entrance: json['entrance'],
    apartment: json['apartment'],
    lat: json['lat'],
    long: json['long'],


    createdAt: DateTime.parse(json['created_at']),
    lastLogin: json['last_login'] != null ? DateTime.parse(json['last_login']) : null
  );
}