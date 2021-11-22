// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/network_info.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/data/datasources/login/remote_datasource.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/entities/promotion_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/repositories/login/promotions_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/usecases/get_promotions.dart';


class PromotionsRepositoryImpl implements PromotionsRepository {
  final PromotionsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  PromotionsRepositoryImpl(
      this.remoteDataSource, this.networkInfo);






  @override
  Future<Either<Failure, List<PromotionEntity>>> getPromotions(GetPromotionsWithPaginationParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getPromotions(params.page);
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

