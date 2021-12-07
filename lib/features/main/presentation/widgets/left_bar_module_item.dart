import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';

class LeftBarModuleItem extends StatelessWidget {
  final String text;
  final IconData? icon;
  final String? iconText;
  final Function() onTap;

  final Animation<Offset> animation;
  final AnimationController animationController;
  const LeftBarModuleItem({Key? key, required this.text, this.icon, this.iconText, required this.onTap, required this.animation, required this.animationController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: SlideTransition(
        position: animation,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon == null
                  ? Text(iconText!, style: TextStyles.grey_18_w700.copyWith(fontSize: 18),)
                  : Icon(
                    icon,
                    size: 26,
                    color: ColorStyles.main_grey,
                  ),
                  SizedBox(width: 10.w,),
                  Text(text, style: TextStyles.white_18_w700,),
                ],
              ),
              Icon(
                // Icons.keyboard_arrow_right_sharp,
                Icons.arrow_forward_ios_rounded,
                size: 26,
                color: ColorStyles.main_grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}