// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/repositories/login/home_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/entities/promotion_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/repositories/login/promotions_repository.dart';

class GetPromotionsWithPagination implements UseCase<List<PromotionEntity>, GetPromotionsWithPaginationParams> {
  final PromotionsRepository repository;

  GetPromotionsWithPagination(this.repository);

  @override
  Future<Either<Failure, List<PromotionEntity>>> call(GetPromotionsWithPaginationParams params) async {
    return await repository.getPromotions(params);
  }
}


class GetPromotionsWithPaginationParams extends Equatable {
  final int page;

  GetPromotionsWithPaginationParams({required this.page});

  @override
  List<Object> get props => [page];
}