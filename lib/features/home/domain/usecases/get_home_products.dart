// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/repositories/login/home_repository.dart';

class GetHomeProductsWithPagination implements UseCase<List<ProductEntity>, GetHomeProductsWithPaginationParams> {
  final HomeRepository repository;

  GetHomeProductsWithPagination(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(GetHomeProductsWithPaginationParams params) async {
    return await repository.getHomeProducts(params);
  }
}

class GetHomeProductsWithPaginationParams extends Equatable {
  final int page;

  GetHomeProductsWithPaginationParams({required this.page});

  @override
  List<Object> get props => [page];
}