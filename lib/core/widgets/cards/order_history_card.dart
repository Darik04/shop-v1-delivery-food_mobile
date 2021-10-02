import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/product_to_cart_mini_btn.dart';
import 'package:shopv1deliveryfood_mobile/features/history_orders/presentation/widgets/dotted_line_with_price.dart';


class OrderHistoryCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: ColorStyles.green_accent, width: 1.w),
        color: ColorStyles.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: ColorStyles.green_accent, blurRadius: 2)
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Заказ №36', style: TextStyles.black_16_w700,),
            ],
          ),
          SizedBox(height: 5.h,),
          
          DottedLineWithPriceCustom(
            title: 'Куринные ножки',
            price: 2000,
            count: 2,
          ),
          DottedLineWithPriceCustom(
            title: 'Бургер какой-то',
            price: 1500,
            count: 1,
          ),

          Text('Общая цена:', style: TextStyles.grey_14_w400,),
          SizedBox(height: 2.h,),
          Text('5000 тг.', style: TextStyles.green_14_w700),
          SizedBox(height: 10.h,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Доставлен', style: TextStyles.green_14_w700,),
              Text('13 сент. 2021 19:32', style: TextStyles.grey_12_w400,),

            ],
          )

        ],
      ),
    );
  }
}