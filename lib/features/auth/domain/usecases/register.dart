// ignore: import_of_legacy_library_into_null_safe
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/repositories/login/login_repository.dart';

class Register implements UseCase<bool, RegisterParams> {
  final LoginRepository repository;

  Register(this.repository);

  @override
  Future<Either<Failure, bool>> call(RegisterParams params) async {
    return await repository.register(params);
  }
}

class RegisterParams extends Equatable {
  final String phoneNumber;
  final String lastName;
  final String firstName;
  final File? avatar;
  final int cityId;

  RegisterParams({required this.phoneNumber, required this.lastName, required this.firstName, required this.cityId, this.avatar});

  @override
  List<Object> get props => [phoneNumber];
}