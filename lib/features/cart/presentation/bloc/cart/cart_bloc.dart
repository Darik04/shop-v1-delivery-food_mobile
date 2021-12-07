import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/usecases/add_to_cart.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/usecases/clear_cart.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/usecases/delete_from_cart.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/usecases/get_cart_products.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartProducts getCartProducts; 
  final AddToCart addToCart;
  final ClearCart clearCart;
  final DeleteFromCart deleteFromCart;
  
  CartBloc(this.getCartProducts, this.addToCart, this.clearCart, this.deleteFromCart) : super(CartInitialState());
  
  PaginaitonEntity? pagination;
  List<ProductEntity> products = [];
  int page = 0;
  bool isLoading = false;

  //Cart system
  int cartPrice = 0;

  void refreshPrice(){
    int newPrice = 0;
    for(var i = 0; i < products.length; i++){
      for(var j = 0; j < products[i].countInCart; j++){
        newPrice += products[i].price;
      }
    }
    cartPrice = newPrice;
  }

  @override
  Stream<CartState> mapEventToState(CartEvent event) async*{
    if(event is GetCartProductsEvent && !isLoading){
      if((pagination != null && pagination!.nextUrl != null) || pagination == null){
        yield page == 0 ? CartLoadingState() : CartBlankState();
        page++;
        isLoading = true;
        var gotProducts = await getCartProducts(GetCartProductsParams(page: page));

        yield gotProducts.fold(
          (failure){
            print('ERROR: ${failure}');
            if(failure is ConnectionFailure){
              return InternetConnectionFailureState();
            }
            if(failure is ServerFailure){
              return CartErrorState(message: failure.message);
            }
            return CartErrorState(message: 'Не смогли загрузить продукты');
          },
          (paginationS){
            pagination = paginationS;
            if(paginationS.results.isNotEmpty && paginationS.results != null && paginationS != null){
              products.addAll(paginationS.results as List<ProductEntity>);
            }
            isLoading = false;
            refreshPrice();

            return CartProductsGotSuccessState(products: products);
          }
        );
      }
      
    }





    if(event is AddToCartEvent || event is DeleteFromCartEvent){
      yield CartBlankState();
      if(event is AddToCartEvent){
        addToCart(AddToCartParams(productId: event.product.id));

        if(products.any((el) => el.id == event.product.id)){
          for(var i = 0; i < products.length; i++){
            if(products[i].id == event.product.id){
              if(products[i].countInCart != products[i].maxCountInCart && !event.product.isNew){
                print('COUNTED TO CART ${event.product.countInCart}');
                products[i].countInCart = products[i].countInCart + 1;
              }
            }
          }
        }else{
          print('ADDED TO CART');
          products = products.reversed.toList();
          ProductEntity newProduct = event.product;
          newProduct.isNew = true;
          products.add(newProduct);
          products = products.reversed.toList();
        }
          
        
      }
      if(event is DeleteFromCartEvent){
        deleteFromCart(DeleteFromCartParams(productId: event.productId));
        if(products.any((el) => el.id == event.productId)){
          for(var i = 0; i < products.length; i++){
            if(products[i].id == event.productId && !products[i].isNew){
              if(products[i].countInCart == 1){
                products.removeWhere((element) => element.id == products[i].id);
              }else{
                products[i].countInCart = products[i].countInCart - 1;
              }
            }



            if(products.isNotEmpty && products[i].countInCart == 0){
              products.removeWhere((element) => element.id == products[i].id);
            }
          }
        }
      }

      refreshPrice();

    }




    if(event is ClearCartEvent && products.isNotEmpty){
      yield CartLoadingState();
      var cleared = await clearCart(NoParams());

      yield cleared.fold(
        (failure){
          print('ERROR: ${failure}');
          if(failure is ConnectionFailure){
            return InternetConnectionFailureState();
          }
          if(failure is ServerFailure){
            return CartErrorState(message: failure.message);
          }
          return CartErrorState(message: 'Не смогли очистить корзину');
        },
        (success){
          page = 0;
          products.clear();
          pagination!.nextUrl = null;
          pagination!.prevUrl = null;
          return CartProductsGotSuccessState(products: products, refresh: true);
        }
      );
      refreshPrice();
    }
  }

}


