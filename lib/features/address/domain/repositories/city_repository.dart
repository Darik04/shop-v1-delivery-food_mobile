
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/entities/city_entity.dart';

abstract class CityRepository {
  Future<Either<Failure, List<CityEntity>>> getAllCities();

}