import 'package:equatable/equatable.dart';
import 'city_entity.dart';

class AddressEntity extends Equatable {
  final CityEntity? city;
  final String street;
  final String homeNumber;
  final String? entrance;
  final String? apartment;
  AddressEntity({
    required this.city,
    required this.street,
    required this.homeNumber,
    required this.entrance,
    required this.apartment,
  });



  @override
  List<Object> get props => [
        street,
        homeNumber
      ];
}
