
import 'package:shopv1deliveryfood_mobile/features/home/data/models/category_model.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity{
  ProductModel({
    required int id,
    required int countInCart,
    required int price,
    required int maxCountInCart,
    required num discountPercent,
    required String title,
    required String description,
    required String photo,
    required CategoryModel category,
    required DateTime createdAt,


  }) : super(
    id: id,
    category: category,
    maxCountInCart: maxCountInCart,
    price: price,
    title: title,
    description: description,
    photo: photo,
    discountPercent: discountPercent,
    createdAt: createdAt,
    countInCart: countInCart
    
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    category: CategoryModel.fromJson(json['category']),
    createdAt: DateTime.parse(json['created_at']),
    maxCountInCart: json['max_count_in_cart'],
    price: json['price'],
    discountPercent: json['discount_percent'],
    photo: json['main_photo'],
    description: json['description'],
    title: json['title'],
    countInCart: json['product_in_cart']['count'],


  );
}