import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/entities/city_entity.dart';

class PromotionEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String? image;
  final String? promoCode;
  final num? discount;

  PromotionEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.promoCode,
    required this.discount
  });



  @override
  List<Object> get props => [
        id,
        title,
        description,
      ];
}
