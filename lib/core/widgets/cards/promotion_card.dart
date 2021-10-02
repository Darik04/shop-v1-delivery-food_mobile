import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';


class PromotionCard extends StatelessWidget {
  const PromotionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4)
        ],
        borderRadius: BorderRadius.circular(5),
        color: ColorStyles.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              height: 140.h,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              image: NetworkImage('https://world-sewing-machines.ru/image/cache/catalog/demo/sales/birthday-867x433.jpg'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Text('Получи скидку в честь дня рождения', style: TextStyles.black_16_w700,),
          ),
          
        ],
      ),
    );
  }
}