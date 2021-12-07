// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/repositories/login/cart_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/repositories/login/favorite_products_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/enums/sort_enum.dart';

class GetCartProducts implements UseCase<PaginaitonEntity, GetCartProductsParams> {
  final CartRepository repository;

  GetCartProducts(this.repository);

  @override
  Future<Either<Failure, PaginaitonEntity>> call(GetCartProductsParams params) async {
    return await repository.getCartProducts(params);
  }
}


class GetCartProductsParams extends Equatable {
  final int page;

  GetCartProductsParams({required this.page});

  @override
  List<Object> get props => [];
}