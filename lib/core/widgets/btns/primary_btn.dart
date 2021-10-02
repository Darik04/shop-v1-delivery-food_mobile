import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';


class PrimaryBtn extends StatelessWidget {
  final String text;
  final Function() onTap;
  PrimaryBtn({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 380.w,
        padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorStyles.primary
        ),
        alignment: Alignment.center,
        child: Text(text, style: TextStyles.white_16_w700,),
      ),
    );
  }
}