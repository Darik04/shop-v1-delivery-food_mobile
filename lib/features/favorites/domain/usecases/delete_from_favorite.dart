// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/repositories/login/favorite_products_repository.dart';

class DeleteFromFavorite implements UseCase<bool, DeleteFromFavoriteParams> {
  final FavoriteProductsRepository repository;

  DeleteFromFavorite(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeleteFromFavoriteParams params) async {
    return await repository.deleteFromFavorite(params);
  }
}


class DeleteFromFavoriteParams extends Equatable {
  final int productId;

  DeleteFromFavoriteParams({required this.productId});

  @override
  List<Object> get props => [productId];
}