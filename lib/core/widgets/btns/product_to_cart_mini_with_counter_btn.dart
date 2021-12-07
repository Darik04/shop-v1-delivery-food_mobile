import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';


class ProductToCartMiniWithCounterBtn extends StatelessWidget {
  final int count;
  final int maxCount;
  final Function() onAdd;
  final Function() onRemove;
  const ProductToCartMiniWithCounterBtn({Key? key, required this.count, required this.onAdd, required this.onRemove, required this.maxCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      height: 40.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 2, color: ColorStyles.primary)

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: onRemove,
            child: Text('-', style: TextStyles.primary_30_w700)
          ),
          Text('${count}', style: TextStyles.primary_18_w700),
          maxCount == count 
          ? Text(' ', style: TextStyles.primary_30_w700)
          : GestureDetector(
            onTap: onAdd,
            child: Text('+', style: TextStyles.primary_30_w700),
          ),
          
        ],
      )
    );
  }
}