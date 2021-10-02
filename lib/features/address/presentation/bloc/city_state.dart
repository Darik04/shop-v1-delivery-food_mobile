part of 'city_bloc.dart';

class CityState extends Equatable {
  const CityState();
  @override
  List<Object> get props => [];
}

class InitialState extends CityState {}
class LoadingState extends CityState {}
class ErrorState extends CityState {
  final String message;
  ErrorState({required this.message});
}
class SuccessGotAllCitiesState extends CityState {
  final List<CityEntity> cities;
  SuccessGotAllCitiesState({required this.cities});
}

