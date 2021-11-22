
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/usecases/send_code_for_change_phone.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/usecases/update_phone.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/usecases/update_user_info.dart';

abstract class ProfileRepository {
  Future<Either<Failure, bool>> updateUserInfo(UpdateUserInfoParams params);
  Future<Either<Failure, bool>> sendCodeForChangePhone(SendCodeForChangePhoneParams params);
  Future<Either<Failure, bool>> updatePhoneNumber(UpdatePhoneNumberParams params);

}