
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/usecases/add_to_favorite.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/usecases/delete_from_favorite.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/usecases/get_favorite_products.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';

abstract class FavoriteProductsRepository {
  Future<Either<Failure, PaginaitonEntity>> getFavoriteProducts(GetFavoriteProductsParams params);
  Future<Either<Failure, bool>> addToFavorite(AddToFavoriteParams params);
  Future<Either<Failure, bool>> deleteFromFavorite(DeleteFromFavoriteParams params);

}