// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/repositories/login/favorite_products_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/enums/sort_enum.dart';

class AddToFavorite implements UseCase<bool, AddToFavoriteParams> {
  final FavoriteProductsRepository repository;

  AddToFavorite(this.repository);

  @override
  Future<Either<Failure, bool>> call(AddToFavoriteParams params) async {
    return await repository.addToFavorite(params);
  }
}


class AddToFavoriteParams extends Equatable {
  final int productId;

  AddToFavoriteParams({required this.productId});

  @override
  List<Object> get props => [productId];
}