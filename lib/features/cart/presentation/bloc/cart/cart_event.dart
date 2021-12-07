part of 'cart_bloc.dart';

class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class GetCartProductsEvent extends CartEvent{}

class AddToCartEvent extends CartEvent{
  final ProductEntity product;
  AddToCartEvent({required this.product});
}
class DeleteFromCartEvent extends CartEvent{
  final int productId;
  DeleteFromCartEvent({required this.productId});
}

class ClearCartEvent extends CartEvent{}