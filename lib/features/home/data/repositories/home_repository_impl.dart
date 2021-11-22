// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/network_info.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/home/data/datasources/login/remote_datasource.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/category_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/repositories/login/home_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/usecases/get_home_products.dart';

import '../../../../locator.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  HomeRepositoryImpl(
      this.remoteDataSource, this.networkInfo);




  @override
  Future<Either<Failure, List<ProductEntity>>> getHomeProducts(GetHomeProductsWithPaginationParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getHomeProducts(params.page);
        return Right(items);
      } catch (e) {
        print(e);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }


  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories(NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getCategories();
        return Right(items);
      } catch (e) {
        print(e);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

}

