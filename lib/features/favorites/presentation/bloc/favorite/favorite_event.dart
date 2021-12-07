part of 'favorite_bloc.dart';

class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class GetFavoriteProductsEvent extends FavoriteEvent{}

class AddToFavoriteEvent extends FavoriteEvent{
  final ProductEntity product;
  final bool? inFavorite;
  AddToFavoriteEvent({required this.product, this.inFavorite = false});
}

class DeleteFromFavoriteEvent extends FavoriteEvent{
  final int productId;
  DeleteFromFavoriteEvent({required this.productId});
}