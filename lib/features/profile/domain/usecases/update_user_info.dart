// ignore: import_of_legacy_library_into_null_safe
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/repositories/profile/profile_repository.dart';

class UpdateUserInfo implements UseCase<bool, UpdateUserInfoParams> {
  final ProfileRepository repository;

  UpdateUserInfo(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdateUserInfoParams params) async {
    return await repository.updateUserInfo(params);
  }
}


class UpdateUserInfoParams extends Equatable {
  final String firstName;
  final String lastName;
  final int cityId;
  final File? avatar;
  UpdateUserInfoParams({required this.firstName, required this.lastName, required this.cityId, this.avatar});

  @override
  List<Object> get props => [firstName, lastName];
}