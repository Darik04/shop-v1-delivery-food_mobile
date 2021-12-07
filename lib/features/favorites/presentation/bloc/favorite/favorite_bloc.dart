import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/usecases/add_to_favorite.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/usecases/delete_from_favorite.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/usecases/get_favorite_products.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoriteProducts getFavoriteProducts; 
  final AddToFavorite addToFavorite;
  final DeleteFromFavorite deleteFromFavorite;
  
  FavoriteBloc(this.getFavoriteProducts, this.addToFavorite, this.deleteFromFavorite) : super(FavoriteInitialState());
  
  PaginaitonEntity? pagination;
  List<ProductEntity> products = [];
  int page = 0;
  bool isLoading = false;

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async*{
    if(event is GetFavoriteProductsEvent && !isLoading){
      if((pagination != null && pagination!.nextUrl != null) || pagination == null){
        yield page == 0 ? FavoriteLoadingState() : FavoriteBlankState();
        page++;
        isLoading = true;
        var gotProducts = await getFavoriteProducts(GetFavoriteProductsParams(page: page));

        yield gotProducts.fold(
          (failure){
            print('ERROR: ${failure}');
            if(failure is ConnectionFailure){
              return InternetConnectionFailureState();
            }
            if(failure is ServerFailure){
              return FavoriteErrorState(message: failure.message);
            }
            return FavoriteErrorState(message: 'Не смогли загрузить продукты');
          },
          (paginationS){
            pagination = paginationS;
            if(paginationS.results.isNotEmpty && paginationS.results != null && paginationS != null){
              products.addAll(paginationS.results as List<ProductEntity>);
            }
            isLoading = false;
            return FavoriteProductsGotSuccessState(products: products);
          }
        );
      }
      
    }




    if(event is AddToFavoriteEvent || event is DeleteFromFavoriteEvent){
      yield FavoriteBlankState();
      if(event is AddToFavoriteEvent){
        addToFavorite(AddToFavoriteParams(productId: event.product.id));
        products = products.reversed.toList();
        products.add(event.product);
        products = products.reversed.toList();
      }
      if(event is DeleteFromFavoriteEvent){
        deleteFromFavorite(DeleteFromFavoriteParams(productId: event.productId));
        products.removeWhere((element) => element.id == event.productId);
      }
      FavoriteProductsGotSuccessState(products: products);
    }


    
  }

}
