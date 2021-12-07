// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/exceptions.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/network_info.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/data/datasources/list_products/remote_datasource.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/repositories/login/favorite_products_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/usecases/add_to_favorite.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/usecases/delete_from_favorite.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/usecases/get_favorite_products.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';


class FavoriteProductsRepositoryImpl implements FavoriteProductsRepository {
  final FavoriteProductsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  FavoriteProductsRepositoryImpl(
      this.remoteDataSource, this.networkInfo);






  @override
  Future<Either<Failure, PaginaitonEntity>> getFavoriteProducts(GetFavoriteProductsParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final pagination = await remoteDataSource.getFavoriteProducts(params.page);
        return Right(pagination);
      } catch (e) {
        print(e);
        if(e is ServerException){
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }




  @override
  Future<Either<Failure, bool>> addToFavorite(AddToFavoriteParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final success = await remoteDataSource.addToFavorite(params.productId);
        return Right(success);
      } catch (e) {
        print(e);
        if(e is ServerException){
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }




  @override
  Future<Either<Failure, bool>> deleteFromFavorite(DeleteFromFavoriteParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final success = await remoteDataSource.deleteInFavoriteProduct(params.productId);
        return Right(success);
      } catch (e) {
        print(e);
        if(e is ServerException){
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

}

