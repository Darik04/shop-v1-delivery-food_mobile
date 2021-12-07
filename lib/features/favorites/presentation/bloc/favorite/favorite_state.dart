part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  const FavoriteState();
  @override
  List<Object> get props => [];
}

class FavoriteInitialState extends FavoriteState {}
class FavoriteLoadingState extends FavoriteState {}
class FavoriteErrorState extends FavoriteState {
  final String message;
  FavoriteErrorState({required this.message});
}
class InternetConnectionFailureState extends FavoriteState {}
class FavoriteProductsGotSuccessState extends FavoriteState{
  final List<ProductEntity> products;
  FavoriteProductsGotSuccessState({required this.products});
}
class FavoriteBlankState extends FavoriteState{}