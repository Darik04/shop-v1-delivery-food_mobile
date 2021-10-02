// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/entities/city_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/repositories/city_repository.dart';

class GetAllCities implements UseCase<List<CityEntity>, NoParams> {
  final CityRepository repository;

  GetAllCities(this.repository);

  @override
  Future<Either<Failure, List<CityEntity>>> call(NoParams params) async {
    return await repository.getAllCities();
  }
}
