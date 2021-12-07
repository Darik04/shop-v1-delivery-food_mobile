import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';

class LeftBarModuleHeader extends StatelessWidget {
  final String text;
  final Animation<Offset> animation;
  const LeftBarModuleHeader({Key? key, required this.text, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: Row(
        children: [
          Container(
            width: 18.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: ColorStyles.main_grey,
            ),
          ),
          SizedBox(width: 10.w,),
          Text(text, style: TextStyles.white_18_w700,),
          
        ],
      ),
    );
  }
}