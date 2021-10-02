// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/repositories/login/login_repository.dart';

class GetTokenLocal implements UseCase<String?, NoParams> {
  final LoginRepository repository;

  GetTokenLocal(this.repository);

  @override
  Future<Either<Failure, String?>> call(NoParams params) async {
    return await repository.getTokenLocal(params);
  }
}
