import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/category_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/usecases/get_categories.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/usecases/get_home_products.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeProductsWithPagination getHomeProductsWithPagination; 
  final GetCategories getCategories; 
  
  HomeBloc(this.getHomeProductsWithPagination, this.getCategories) : super(HomeInitialState());

  List<CategoryEntity> categories = [];
  List<ProductEntity> products = [];
  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    if(event is GetHomeProductsWithPaginationEvent){
      yield HomeLoadingState();
      var productsGot = await getHomeProductsWithPagination(GetHomeProductsWithPaginationParams(page: 1));
      var categoriesGot = await getCategories(NoParams());
      //Folding products
      yield productsGot.fold(
        (failure){
          print('ERROR: ${failure}');
          if(failure is ConnectionFailure){
            return InternetConnectionFailureState();
          }
          return HomeErrorState(message: 'Не смогли загрузить продукты');
        },
        (productsS){
          products = productsS;
          //Folding categories
          categoriesGot.fold(
            (failure){
              if(failure is ConnectionFailure){
                return InternetConnectionFailureState();
              }
              return HomeErrorState(message: 'Не смогли загрузить категории');
            },
            (categoriesS){
              categories = categoriesS;
            }
          );

          return GotSuccessHomeProductsAndCategoriesState(categories: categories, products: products);

        }
      );

    }


    


    
  }

}
