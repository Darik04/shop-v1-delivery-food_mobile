import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/helpers/cart_helper.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/toasts.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/shadow_primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/cart_card.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/loaders/loader_v1.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/order/presentation/views/order_create_view.dart';



class CartView extends StatefulWidget {

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  ScrollController _scrollController = ScrollController();

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels)
        context.read<CartBloc>().add(GetCartProductsEvent());
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
    CartBloc cartBloc = context.read<CartBloc>();
    return Scaffold(
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state){
          if(state is CartErrorState){
            showAlertToast(state.message);
          }
          if(state is CartProductsGotSuccessState){
            setState(() {});
            if(state.refresh){
              context.read<HomeBloc>().add(GetHomeProductsWithPaginationEvent());

            }
          }
        },
        builder: (context, state) {
          if(state is CartInitialState || state is CartLoadingState){
            return LoaderV1();
          }
          if(state is CartProductsGotSuccessState || state is CartBlankState){
            return SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.h),
                child: cartBloc.products.isEmpty
                ? _buildEmptyScreen(context)
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(height: 15.h,),

                    ...cartBloc.products.map((product)
                      => product.countInCart == 0
                      ? SizedBox.shrink()
                      : CartCard(
                      productEntity: product,
                      onTap: (){},
                      removeFromCartTap: (){
                        setState(() {
                          deleteFromCart(context: context, productEntity: product);
                        });
                      },
                      addToCartTap: (){
                        setState(() {
                          addToCart(context: context, productEntity: product);
                        });
                      },
                      isLast: cartBloc.products.last == product,
                    )),


                    cartBloc.pagination!.nextUrl == null
                    ? SizedBox(height: 240.h,)
                    : SizedBox(height: 60.h,)
                    
                  ],
                ),
              ),
            );
          }


          return Container();
          
        }
      ),


      floatingActionButton: context.read<CartBloc>().products.isNotEmpty 
      ? Column(
        mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadowPrimaryBtn(
            text: 'Оформить заказ на: ${context.read<CartBloc>().cartPrice} ₸',
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OrderCreateView()));
            },
            paddingV: 22.h,
          ),
        ],
      )
      : SizedBox.shrink()
    );
  }
}


Widget _buildEmptyScreen(BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 5.h,),
        Container(
          height: 140.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('У вас в корзине нет\n товаров', style: TextStyles.cart_empty_text, textAlign: TextAlign.center,),
              SizedBox(height: 10.h,),

              ShadowPrimaryBtn(
                text: 'Перейти в меню',
                paddingV: 14.h,
                onTap: (){
                  context.read<MainScreenBloc>().add(ChangeViewEvent(view: 0));
                },
              )

            ],
          ),
        ),
        SizedBox(height: 240.h,)
      ],
    ),
  );
}