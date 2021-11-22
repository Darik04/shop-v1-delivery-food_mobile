import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/category_entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final CategoryEntity category;
  final int countInCart;
  final String title;
  final String description;
  final String photo;
  final int price;
  final int maxCountInCart;
  final num discountPercent;
  final DateTime createdAt;


  ProductEntity( {
    required this.id,
    required this.category,
    required this.countInCart,
    required this.title,
    required this.description,
    required this.photo,
    required this.price,
    required this.maxCountInCart,
    required this.createdAt,
    required this.discountPercent,
  });

  @override
  List<Object> get props => [
    id,
    countInCart,
    title,
    discountPercent,
    category,
    description,
    price,
    photo,
    createdAt,
    maxCountInCart

  ];
}
