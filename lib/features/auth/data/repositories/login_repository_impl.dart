// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/network_info.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/data/datasources/login/local_datasource.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/data/datasources/login/remote_datasource.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/data/models/token_model.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/token_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/repositories/login/login_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/auth_signin.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/get_token_local.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/register.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/send_sms.dart';

import '../../../../locator.dart';

class LoginRepositoryImpl implements LoginRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  LoginRepositoryImpl(
      this.remoteDataSource, this.networkInfo, this.localDataSource);




  @override
  Future<Either<Failure, String>> sendSMS(PhoneParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final isSended = await remoteDataSource.sendSMS(params.phoneNumber);
        return Right(isSended);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, TokenEntity>> authSignIn(AuthSignParams params) async {
    if (await networkInfo.isConnected) {
      try {
        TokenModel tokenEntity = await remoteDataSource.authSignIn(
            params.phoneNumber, params.code);
        // if(tokenEntity.token != '' && tokenEntity.registered == 1){
        bool isSavedToken = await localDataSource.saveToken(tokenEntity.token);
        if (isSavedToken) {
          return Right(tokenEntity);
        } else {
          return Left(CacheFailure());
        }

        // }
        // return Right(tokenEntity);

      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  /// Получение информации с бэка
  /// о покупателе(о user-е)
  @override
  Future<Either<Failure, UserEntity>> getUserInfo(NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        var userModel = await remoteDataSource.getUserInfo();
        return Right(userModel);
      } catch (e) {
        print(e);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }



  /// Получение информации с бэка
  /// о покупателе(о user-е)
  @override
  Future<Either<Failure, String?>> getTokenLocal(NoParams params) async {
    try {
      var token = await localDataSource.getToken();
      return Right(token);
    } catch (e) {
      return Left(CacheFailure());
    }
  }



  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      bool isDeletedToken = await localDataSource.deleteToken();
      String token = sl<AuthConfig>().token!;
      if (isDeletedToken) {
        return Right(true);
      } else {
        return Left(CacheFailure());
      }
    } catch (e) {
      return Left(CacheFailure());
    }
  }



  @override
  Future<Either<Failure, bool>> register(RegisterParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final isSended = await remoteDataSource.register(
          phone: params.phoneNumber,
          firstName: params.firstName,
          lastName: params.lastName,
          avatar: params.avatar,
          cityId: params.cityId
        );
        return Right(isSended);
      } catch (e) {
        print(e);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

