// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/token_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/repositories/login/login_repository.dart';

class AuthSignIn implements UseCase<TokenEntity, AuthSignParams> {
  final LoginRepository repository;

  AuthSignIn(this.repository);

  @override
  Future<Either<Failure, TokenEntity>> call(AuthSignParams params) async {
    return await repository.authSignIn(params);
  }
}

class AuthSignParams extends Equatable {
  final String phoneNumber;
  final String code;

  AuthSignParams({required this.phoneNumber, required this.code});

  @override
  List<Object> get props => [phoneNumber, code];
}