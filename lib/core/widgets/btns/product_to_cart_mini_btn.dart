import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';


class ProductToCartMiniBtn extends StatelessWidget {
  final String text;
  final Function() onTap;
  const ProductToCartMiniBtn({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      height: 40.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorStyles.primary,
        borderRadius: BorderRadius.circular(30),

      ),
      child: Text('В корзину', style: TextStyles.white_16_w700),
    );
  }
}