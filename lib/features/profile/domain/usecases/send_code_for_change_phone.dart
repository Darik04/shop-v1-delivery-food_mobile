// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/repositories/profile/profile_repository.dart';

class SendCodeForChangePhone implements UseCase<bool, SendCodeForChangePhoneParams> {
  final ProfileRepository repository;

  SendCodeForChangePhone(this.repository);

  @override
  Future<Either<Failure, bool>> call(SendCodeForChangePhoneParams params) async {
    return await repository.sendCodeForChangePhone(params);
  }
}


class SendCodeForChangePhoneParams extends Equatable {
  final String newPhone;
  SendCodeForChangePhoneParams({required this.newPhone});

  @override
  List<Object> get props => [newPhone];
}