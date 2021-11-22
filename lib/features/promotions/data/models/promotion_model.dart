import 'package:shopv1deliveryfood_mobile/features/promotions/domain/entities/promotion_entity.dart';

class PromotionModel extends PromotionEntity{
  PromotionModel({
    required int id,
    required String title,
    required String description,
    required String? image,
    required String? promoCode,
    required num? discount,

  }) : super(
    id: id, 
    title: title,
    description: description,
    image: image,
    promoCode: promoCode,
    discount: discount
  );

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    image: json['main_photo'],
    promoCode: json['promo_code'],
    discount: json['discount'],
    
  );
}