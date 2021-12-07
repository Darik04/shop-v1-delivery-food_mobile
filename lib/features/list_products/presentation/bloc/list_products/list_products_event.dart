part of 'list_products_bloc.dart';

class ListProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class GetProductsEvent extends ListProductsEvent{
  final int? categoryId;
  final SortByEnum sortByEnum;
  GetProductsEvent({this.categoryId, required this.sortByEnum});
}