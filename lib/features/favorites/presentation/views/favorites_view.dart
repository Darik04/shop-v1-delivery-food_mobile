import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/toasts.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/product_card.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/loaders/loader_v1.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/product_details/presentation/views/product_details_view.dart';

import '../../../../locator.dart';


class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  ScrollController _scrollController = ScrollController();

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels)
        context.read<FavoriteBloc>().add(GetFavoriteProductsEvent());
      
    });
    
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
  FavoriteBloc favoriteBloc = context.read<FavoriteBloc>();
    return Scaffold(
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state){
          if(state is FavoriteErrorState){
            showAlertToast(state.message);
          }
        },
        builder: (context, state) {
          if(state is FavoriteInitialState || state is FavoriteLoadingState){
            return LoaderV1();
          }
          if(state is FavoriteProductsGotSuccessState || state is FavoriteBlankState){
            if(favoriteBloc.products.isEmpty){
              return Center(child: Text('Пока нет товаров', style: TextStyles.black_14_w400,),);
            }
            return SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(height: 10,),
                    ...favoriteBloc.products.map((product) 
                      => ProductCard(
                        productEntity: product,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetailsView(productId: product.id)));
                        },
                        addToCartTap: (){
                          
                          if(sl<AuthConfig>().authenticatedOption == AuthenticatedOption.authenticated){
                            setState(() {
                              product.countInCart++;
                            });
                            context.read<CartBloc>().add(DeleteFromCartEvent(productId: product.id));
                          }else{
                            context.read<AuthBloc>().add(OpenAuthFormEvent());
                          }
                        },
                        addToFavoritesTap: (){
                          if(sl<AuthConfig>().authenticatedOption == AuthenticatedOption.authenticated){
                            setState(() {
                              if(product.countInFavorite == 0){
                                product.countInFavorite = 1;
                                context.read<FavoriteBloc>().add(AddToFavoriteEvent(product: product,));
                              }else{
                                product.countInFavorite = 0;
                                favoriteBloc.products.removeWhere((element) => element.id == product.id);
                                context.read<FavoriteBloc>().add(DeleteFromFavoriteEvent(productId: product.id,));
                              }
                            });
                            context.read<HomeBloc>().add(GetHomeProductsWithPaginationEvent());
                          }else{
                            context.read<AuthBloc>().add(OpenAuthFormEvent());
                          }
                        },
                        removeFromCartTap: (){
                          if(sl<AuthConfig>().authenticatedOption == AuthenticatedOption.authenticated){
                            setState(() {
                              product.countInCart--;
                            });
                            context.read<CartBloc>().add(DeleteFromCartEvent(productId: product.id));
                          }else{
                            context.read<AuthBloc>().add(OpenAuthFormEvent());
                          }
                        },
                      )
                    ).toList()
                  ]
                ),
              ),
            );
          }
          return Container();
        }
      )
    );
  }
}