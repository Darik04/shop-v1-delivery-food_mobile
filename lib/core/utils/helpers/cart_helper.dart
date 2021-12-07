
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/presentation/bloc/list_products/list_products_bloc.dart';
///-- Add to cart --
void addToCart({required BuildContext context, required ProductEntity productEntity}){
  context.read<CartBloc>().add(AddToCartEvent(product: productEntity));

  if(context.read<FavoriteBloc>().products.any((element) => element.id == productEntity.id)){
    for(var i=0; i < context.read<FavoriteBloc>().products.length; i++){
      if(context.read<FavoriteBloc>().products[i].id == productEntity.id 
        && context.read<FavoriteBloc>().products[i].maxCountInCart != productEntity.countInCart){
        context.read<FavoriteBloc>().products[i].countInCart++;
      }
    }
  }

  if(context.read<HomeBloc>().products.any((element) => element.id == productEntity.id)){
    for(var i=0; i < context.read<HomeBloc>().products.length; i++){
      if(context.read<HomeBloc>().products[i].id == productEntity.id 
        && context.read<HomeBloc>().products[i].maxCountInCart != productEntity.countInCart){
        context.read<HomeBloc>().products[i].countInCart++;
      }
    }
  }
  
  if(context.read<ListProductsBloc>().products.any((element) => element.id == productEntity.id)){
    for(var i=0; i < context.read<ListProductsBloc>().products.length; i++){
      if(context.read<ListProductsBloc>().products[i].id == productEntity.id 
        && context.read<ListProductsBloc>().products[i].maxCountInCart != productEntity.countInCart){
        context.read<ListProductsBloc>().products[i].countInCart++;
      }
    }
  }
}






///-- Delete from cart --
void deleteFromCart({required BuildContext context, required ProductEntity productEntity}){
  context.read<CartBloc>().add(DeleteFromCartEvent(productId: productEntity.id));

  if(context.read<FavoriteBloc>().products.any((element) => element.id == productEntity.id)){
    for(var i=0; i < context.read<FavoriteBloc>().products.length; i++){
      if(context.read<FavoriteBloc>().products[i].id == productEntity.id 
        && context.read<FavoriteBloc>().products[i].countInCart != 0){
        context.read<FavoriteBloc>().products[i].countInCart--;
      }
    }
  }

  if(context.read<HomeBloc>().products.any((element) => element.id == productEntity.id)){
    for(var i=0; i < context.read<HomeBloc>().products.length; i++){
      if(context.read<HomeBloc>().products[i].id == productEntity.id 
        && context.read<HomeBloc>().products[i].countInCart != 0){
        context.read<HomeBloc>().products[i].countInCart--;
      }
    }
  }




  if(context.read<ListProductsBloc>().products.any((element) => element.id == productEntity.id)){
    for(var i=0; i < context.read<ListProductsBloc>().products.length; i++){
      if(context.read<ListProductsBloc>().products[i].id == productEntity.id 
        && context.read<ListProductsBloc>().products[i].countInCart != 0){
        context.read<ListProductsBloc>().products[i].countInCart--;
      }
    }
  }
  
}