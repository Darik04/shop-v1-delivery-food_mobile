import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/order_history_card.dart';
import 'package:shopv1deliveryfood_mobile/features/history_orders/presentation/widgets/dotted_line_with_price.dart';

class HistoryOrdersView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('История заказов', style: Theme.of(context).appBarTheme.titleTextStyle,)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('3 заказа', style: TextStyles.grey_14_w400,),
                    Row(
                      children: [
                        Text('Сортировать по', style: TextStyles.grey_14_w400,),
                        Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: ColorStyles.main_grey,
                        )
                      ],
                    )
                  ],
                ),
              ),


              OrderHistoryCard(),
              OrderHistoryCard()
            ],
          ),
        ),
      ),
    );
  }
}