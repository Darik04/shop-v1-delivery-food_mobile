// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/network_info.dart';
import 'package:shopv1deliveryfood_mobile/features/address/data/datasources/remote_datasource.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/entities/city_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/repositories/city_repository.dart';


class CityRepositoryImpl implements CityRepository {
  final CityRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  CityRepositoryImpl(
      this.remoteDataSource, this.networkInfo);




  @override
  Future<Either<Failure, List<CityEntity>>> getAllCities() async {
    if (await networkInfo.isConnected) {
      try {
        final cities = await remoteDataSource.getAllCities();
        return Right(cities);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

}

