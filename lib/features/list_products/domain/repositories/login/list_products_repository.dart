
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/usecases/get_products.dart';

abstract class ListProductsRepository {
  Future<Either<Failure, PaginaitonEntity>> getListProducts(GetProductsParams params);

}