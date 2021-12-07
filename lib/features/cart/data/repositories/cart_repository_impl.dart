// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/exceptions.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/network_info.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/data/datasources/cart/remote_datasource.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/repositories/login/cart_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/usecases/add_to_cart.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/usecases/delete_from_cart.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/usecases/get_cart_products.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';


class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  CartRepositoryImpl(
      this.remoteDataSource, this.networkInfo);






  @override
  Future<Either<Failure, PaginaitonEntity>> getCartProducts(GetCartProductsParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final pagination = await remoteDataSource.getCartProducts(params.page);
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
  Future<Either<Failure, bool>> addToCart(AddToCartParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final success = await remoteDataSource.addToCart(params.productId);
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
  Future<Either<Failure, bool>> deleteFromCart(DeleteFromCartParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final success = await remoteDataSource.deleteFromCart(params.productId);
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
  Future<Either<Failure, bool>> clearCart(NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final success = await remoteDataSource.clearCart();
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

