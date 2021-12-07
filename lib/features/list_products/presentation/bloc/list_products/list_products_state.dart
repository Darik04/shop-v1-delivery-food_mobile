part of 'list_products_bloc.dart';

class ListProductsState extends Equatable {
  const ListProductsState();
  @override
  List<Object> get props => [];
}

class ListProductsInitialState extends ListProductsState {}
class ListProductsLoadingState extends ListProductsState {}
class ListProductsErrorState extends ListProductsState {
  final String message;
  ListProductsErrorState({required this.message});
}
class InternetConnectionFailureState extends ListProductsState {}
class ProductsGotSuccessState extends ListProductsState{
  final PaginaitonEntity pagination;
  ProductsGotSuccessState({required this.pagination});
}
class ListProductsBlankState extends ListProductsState{}