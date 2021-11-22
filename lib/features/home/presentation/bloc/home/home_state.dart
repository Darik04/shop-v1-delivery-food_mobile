part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}
class HomeLoadingState extends HomeState {}
class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required this.message});
}
class InternetConnectionFailureState extends HomeState {}

class GotSuccessHomeProductsAndCategoriesState extends HomeState{
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;
  GotSuccessHomeProductsAndCategoriesState({required this.products, required this.categories});
}
