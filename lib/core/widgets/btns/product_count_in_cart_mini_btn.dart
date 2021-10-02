import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';


class ProductCountInCartMiniBtn extends StatelessWidget {
  final String text;
  final Function() onTap;
  const ProductCountInCartMiniBtn({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: ColorStyles.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 2, color: ColorStyles.primary)
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('-', style: TextStyles.primary_30_w700,),
          Text('2', style: TextStyles.primary_18_w700,),
          Text('+', style: TextStyles.primary_30_w700,),
        ],
      )
    );
  }
}