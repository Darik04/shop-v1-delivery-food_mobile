import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/product_to_cart_mini_btn.dart';


class CategoryCard extends StatelessWidget {
  final String url;
  final Function() func;
  final String text;
  const CategoryCard({Key? key, required this.url, required this.text, required this.func}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Column(
        children: [
          SizedBox(height: 1.h,),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 8.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4),
              ]
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: url == null || url == '' 
                  ? Image(
                    width: 70.h,
                    height: 70.h,
                    image: AssetImage('assets/images/user.png'),
                    fit: BoxFit.cover,
                  ) : Image(
                    width: 70.h,
                    height: 70.h,
                    image: NetworkImage(url),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8,),
                Text(text, style: TextStyles.black_14_w400,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}