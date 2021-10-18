
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/token_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/auth_signin.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/register.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/send_sms.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> sendSMS(PhoneParams params);
  Future<Either<Failure, bool>> register(RegisterParams params);
  Future<Either<Failure, TokenEntity>> authSignIn(AuthSignParams params);
  Future<Either<Failure, UserEntity>> getUserInfo(NoParams params);
  Future<Either<Failure, String?>> getTokenLocal(NoParams params);

  Future<Either<Failure, bool>> logout();

}