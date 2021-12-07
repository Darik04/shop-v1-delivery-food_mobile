import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/enums/sort_enum.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/usecases/get_products.dart';
part 'list_products_event.dart';
part 'list_products_state.dart';

class ListProductsBloc extends Bloc<ListProductsEvent, ListProductsState> {
  final GetProducts getProducts; 
  
  ListProductsBloc(this.getProducts) : super(ListProductsInitialState());

  PaginaitonEntity? pagination;
  List<ProductEntity> products = [];
  int page = 0;
  bool isLoading = false;


  @override
  Stream<ListProductsState> mapEventToState(ListProductsEvent event) async*{
    if(event is GetProductsEvent){
      if((pagination != null && pagination!.nextUrl != null) || pagination == null){
        if(page == 0){
          yield ListProductsLoadingState();
          products.clear();
        }else{
          yield ListProductsBlankState();
        }
        page++;
        isLoading = true;
        var gotProducts = await getProducts(GetProductsParams(categoryId: event.categoryId, page: page, sortByEnum: event.sortByEnum));

        yield gotProducts.fold(
          (failure){
            print('ERROR: ${failure}');
            if(failure is ConnectionFailure){
              return InternetConnectionFailureState();
            }
            if(failure is ServerFailure){
              return ListProductsErrorState(message: failure.message);
            }
            return ListProductsErrorState(message: 'Не смогли загрузить продукты');
          },
          (paginationS){
            pagination = paginationS;
            if(paginationS.results.isNotEmpty && paginationS.results != null && paginationS != null){
              products.addAll(paginationS.results as List<ProductEntity>);
            }
            isLoading = false;
            return ProductsGotSuccessState(pagination: pagination!);
          }
        );
      }
    }


    
  }

}
