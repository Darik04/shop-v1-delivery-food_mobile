
import 'package:shopv1deliveryfood_mobile/features/address/domain/entities/city_entity.dart';

class CityModel extends CityEntity{
  CityModel({
    required int id,
    required String name,
    required int code,

  }) : super(id: id, name: name, code: code);

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json['id'],
    name: json['name'],
    code: json['code']
  );
}