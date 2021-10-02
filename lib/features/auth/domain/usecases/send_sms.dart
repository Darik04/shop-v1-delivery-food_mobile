// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/repositories/login/login_repository.dart';

class SendSMS implements UseCase<String, PhoneParams> {
  final LoginRepository repository;

  SendSMS(this.repository);

  @override
  Future<Either<Failure, String>> call(PhoneParams params) async {
    return await repository.sendSMS(params);
  }
}

class PhoneParams extends Equatable {
  final String phoneNumber;

  PhoneParams({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}