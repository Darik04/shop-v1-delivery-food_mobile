// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/repositories/login/cart_repository.dart';

class AddToCart implements UseCase<bool, AddToCartParams> {
  final CartRepository repository;

  AddToCart(this.repository);

  @override
  Future<Either<Failure, bool>> call(AddToCartParams params) async {
    return await repository.addToCart(params);
  }
}


class AddToCartParams extends Equatable {
  final int productId;

  AddToCartParams({required this.productId});

  @override
  List<Object> get props => [productId];
}