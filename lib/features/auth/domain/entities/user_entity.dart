import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/entities/city_entity.dart';

class UserEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String avatar;
  final bool registered;

  //address
  final CityEntity? city;
  final String? street;
  final String? homeNumber;
  final String? entrance;
  final String? apartment;
  final double? lat;
  final double? long;

  //dates
  final DateTime createdAt;
  final DateTime? lastLogin;

  UserEntity(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.avatar,
      required this.registered,
      required this.city,
      required this.apartment,
      required this.createdAt,
      required this.entrance,
      required this.homeNumber,
      required this.lastLogin,
      required this.lat,
      required this.long,
      required this.street,
      });



  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        phone,
        registered,
        avatar,
        createdAt,
      ];
}
