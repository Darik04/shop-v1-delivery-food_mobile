
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/usecases/add_to_cart.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/usecases/delete_from_cart.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/usecases/get_cart_products.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, PaginaitonEntity>> getCartProducts(GetCartProductsParams params);
  Future<Either<Failure, bool>> addToCart(AddToCartParams params);
  Future<Either<Failure, bool>> deleteFromCart(DeleteFromCartParams params);
  Future<Either<Failure, bool>> clearCart(NoParams params);

}