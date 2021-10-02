import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/product_count_in_cart_mini_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/shadow_primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/cart_card.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/promotion_card.dart';
import 'package:shopv1deliveryfood_mobile/features/order/presentation/views/order_create_view.dart';


class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: false
          ? _buildEmptyScreen(context)
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 15.h,),

              CartCard(
                isLast: false,
              ),
              CartCard(
                isLast: true,
              ),
              SizedBox(height: 10.h,),
              
            ],
          ),
        ),
      ),


      floatingActionButton: true 
      ? Column(
        mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadowPrimaryBtn(
            text: 'Оформить заказ на: 8000 тг.',
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
                text: 'Перейти на меню',
                paddingV: 14.h,
                onTap: (){},
              )

            ],
          ),
        ),
        SizedBox(height: 240.h,)
      ],
    ),
  );
}