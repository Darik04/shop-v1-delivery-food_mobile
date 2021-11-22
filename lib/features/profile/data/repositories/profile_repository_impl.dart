// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/exceptions.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/network_info.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/data/datasources/profile/remote_datasource.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/repositories/profile/profile_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/usecases/send_code_for_change_phone.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/usecases/update_phone.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/usecases/update_user_info.dart';


class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  ProfileRepositoryImpl(
      this.remoteDataSource, this.networkInfo);



  @override
  Future<Either<Failure, bool>> updateUserInfo(UpdateUserInfoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final item = await remoteDataSource.updateUserInfo(
          avatar: params.avatar,
          firstName: params.firstName,
          lastName: params.lastName,
          cityId: params.cityId
        );
        return Right(item);
      } catch (e) {
        print(e);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }


  @override
  Future<Either<Failure, bool>> sendCodeForChangePhone(SendCodeForChangePhoneParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final item = await remoteDataSource.sendCodeForChangePhone(newPhone: params.newPhone);
        return Right(item);
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
  Future<Either<Failure, bool>> updatePhoneNumber(UpdatePhoneNumberParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final item = await remoteDataSource.updatePhoneNumber(code: params.code);
        return Right(item);
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

