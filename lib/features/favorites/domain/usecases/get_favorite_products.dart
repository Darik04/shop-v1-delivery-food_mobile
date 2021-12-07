// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/repositories/login/favorite_products_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/enums/sort_enum.dart';

class GetFavoriteProducts implements UseCase<PaginaitonEntity, GetFavoriteProductsParams> {
  final FavoriteProductsRepository repository;

  GetFavoriteProducts(this.repository);

  @override
  Future<Either<Failure, PaginaitonEntity>> call(GetFavoriteProductsParams params) async {
    return await repository.getFavoriteProducts(params);
  }
}


class GetFavoriteProductsParams extends Equatable {
  final int page;

  GetFavoriteProductsParams({required this.page});

  @override
  List<Object> get props => [];
}