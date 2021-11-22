import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/entities/city_entity.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String icon;

  CategoryEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.icon
  });



  @override
  List<Object> get props => [
        id,
        title,
        description,
        icon
      ];
}
