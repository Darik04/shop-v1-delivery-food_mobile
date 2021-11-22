// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/repositories/profile/profile_repository.dart';

class UpdatePhoneNumber implements UseCase<bool, UpdatePhoneNumberParams> {
  final ProfileRepository repository;

  UpdatePhoneNumber(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdatePhoneNumberParams params) async {
    return await repository.updatePhoneNumber(params);
  }
}


class UpdatePhoneNumberParams extends Equatable {
  final int code;
  UpdatePhoneNumberParams({required this.code});

  @override
  List<Object> get props => [code];
}