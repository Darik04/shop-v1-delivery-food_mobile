// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/repositories/login/cart_repository.dart';

class ClearCart implements UseCase<bool, NoParams> {
  final CartRepository repository;

  ClearCart(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.clearCart(params);
  }
}