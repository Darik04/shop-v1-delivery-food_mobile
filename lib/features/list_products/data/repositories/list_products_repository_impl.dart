// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/exceptions.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/network_info.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/data/datasources/list_products/remote_datasource.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/repositories/login/list_products_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/usecases/get_products.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/entities/promotion_entity.dart';


class ListProductsRepositoryImpl implements ListProductsRepository {
  final ListProductsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  ListProductsRepositoryImpl(
      this.remoteDataSource, this.networkInfo);






  @override
  Future<Either<Failure, PaginaitonEntity>> getListProducts(GetProductsParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final pagination = await remoteDataSource.getListProducts(params.categoryId, params.page, params.sortByEnum);
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

}

