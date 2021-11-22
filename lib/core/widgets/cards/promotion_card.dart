import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/entities/promotion_entity.dart';


class PromotionCard extends StatelessWidget {
  final PromotionEntity promotion;
  const PromotionCard({Key? key, required this.promotion}) : super(key: key);

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
            child: promotion.image == null
            ? Image(
              height: 140.h,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              image: AssetImage('assets/images/user.png'),
            )
            : Image(
              height: 140.h,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              image: NetworkImage(promotion.image!),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Text(promotion.title, style: TextStyles.black_16_w700,),
          ),
          
        ],
      ),
    );
  }
}