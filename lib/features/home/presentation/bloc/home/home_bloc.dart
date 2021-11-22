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

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    if(event is GetHomeProductsWithPaginationEvent){
      yield HomeLoadingState();
      var products = await getHomeProductsWithPagination(GetHomeProductsWithPaginationParams(page: 1));
      var categories = await getCategories(NoParams());
      //Folding products
      yield products.fold(
        (failure){
          print('ERROR: ${failure}');
          if(failure is ConnectionFailure){
            return InternetConnectionFailureState();
          }
          return HomeErrorState(message: 'Не смогли загрузить продукты');
        },
        (products){
          //Folding categories
          List<CategoryEntity> cats = [];
          categories.fold(
            (failure){
              if(failure is ConnectionFailure){
                return InternetConnectionFailureState();
              }
              return HomeErrorState(message: 'Не смогли загрузить категории');
            },
            (categories){
              cats = categories;
            }
          );

          return GotSuccessHomeProductsAndCategoriesState(categories: cats, products: products);

        }
      );

    }


    


    
  }

}
