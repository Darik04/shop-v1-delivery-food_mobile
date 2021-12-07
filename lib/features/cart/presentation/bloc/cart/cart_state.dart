part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState();
  @override
  List<Object> get props => [];
}

class CartInitialState extends CartState {}
class CartLoadingState extends CartState {}
class CartErrorState extends CartState {
  final String message;
  CartErrorState({required this.message});
}
class InternetConnectionFailureState extends CartState {}
class CartProductsGotSuccessState extends CartState{
  final List<ProductEntity> products;
  final bool refresh; 
  CartProductsGotSuccessState({required this.products, this.refresh = false});
}
class CartBlankState extends CartState{}