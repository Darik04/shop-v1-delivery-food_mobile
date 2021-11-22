
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/category_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/usecases/get_home_products.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ProductEntity>>> getHomeProducts(GetHomeProductsWithPaginationParams params);
  Future<Either<Failure, List<CategoryEntity>>> getCategories(NoParams params);

}