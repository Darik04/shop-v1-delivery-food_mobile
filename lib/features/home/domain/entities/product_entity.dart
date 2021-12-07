import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/category_entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final CategoryEntity category;
  int countInCart;
  int countInFavorite;
  final String title;
  final String description;
  final String photo;
  final int price;
  final int maxCountInCart;
  final num discountPercent;
  final DateTime createdAt;

  bool isNew;


  ProductEntity( {
    required this.id,
    required this.category,
    required this.countInCart,
    required this.countInFavorite,
    required this.title,
    required this.description,
    required this.photo,
    required this.price,
    required this.maxCountInCart,
    required this.createdAt,
    required this.discountPercent,
    this.isNew = false
  });

  @override
  List<Object> get props => [
    id,
    countInCart,
    title,
    countInFavorite,
    discountPercent,
    category,
    description,
    price,
    photo,
    createdAt,
    maxCountInCart

  ];
}
