// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/enums/sort_enum.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/repositories/login/list_products_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/entities/promotion_entity.dart';

class GetProducts implements UseCase<PaginaitonEntity, GetProductsParams> {
  final ListProductsRepository repository;

  GetProducts(this.repository);

  @override
  Future<Either<Failure, PaginaitonEntity>> call(GetProductsParams params) async {
    return await repository.getListProducts(params);
  }
}


class GetProductsParams extends Equatable {
  final int? categoryId;
  final int page;
  final SortByEnum sortByEnum;

  GetProductsParams({this.categoryId, required this.page, required this.sortByEnum});

  @override
  List<Object> get props => [];
}