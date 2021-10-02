import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';

class FailReusableModal {
  BuildContext context;
  String title;
  String subTitle;
  String btnTitle;
  Function() onTap;

  FailReusableModal({required this.context, required this.onTap, required this.title, required this.subTitle, required this.btnTitle});
  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            width: MediaQuery.of(context).size.width*0.6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/fail.svg', width: 70.w, height: 70.h,),
                SizedBox(height: 18.h),
                Text(
                  title,
                  style: TextStyles.black_16_w700,
                  textAlign: TextAlign.center
                ),
                SizedBox(height: 10.h),
                Text(
                  subTitle,
                  style: TextStyles.grey_14_w400,
                  textAlign: TextAlign.center
                ),
                SizedBox(height: 16.h),

                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorStyles.red_failure
                    ),
                    alignment: Alignment.center,
                    child: Text(btnTitle, style: TextStyles.white_16_w700,),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
