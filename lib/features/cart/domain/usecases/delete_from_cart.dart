// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/repositories/login/cart_repository.dart';

class DeleteFromCart implements UseCase<bool, DeleteFromCartParams> {
  final CartRepository repository;

  DeleteFromCart(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeleteFromCartParams params) async {
    return await repository.deleteFromCart(params);
  }
}


class DeleteFromCartParams extends Equatable {
  final int productId;

  DeleteFromCartParams({required this.productId});

  @override
  List<Object> get props => [productId];
}