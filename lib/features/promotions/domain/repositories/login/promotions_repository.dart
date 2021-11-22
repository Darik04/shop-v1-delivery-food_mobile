
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/entities/promotion_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/usecases/get_promotions.dart';

abstract class PromotionsRepository {
  Future<Either<Failure, List<PromotionEntity>>> getPromotions(GetPromotionsWithPaginationParams params);

}