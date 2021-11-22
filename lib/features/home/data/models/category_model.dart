
import 'package:shopv1deliveryfood_mobile/features/address/data/models/city_model.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity{
  CategoryModel({
    required int id,
    required String title,
    required String description,
    required String icon,

  }) : super(
    id: id, 
    title: title,
    description: description,
    icon: icon
  );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    icon: json['mini_photo'],
    
  );
}