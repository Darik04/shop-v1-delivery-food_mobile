import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';


class DottedLineWithPriceCustom extends StatelessWidget {
  final String title;
  final int price;
  final int count;
  const DottedLineWithPriceCustom({Key? key, required this.title, required this.price, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyles.black_14_w400,),
            Row(
              children: [
                Text('$price тг.', style: TextStyles.green_14_w700),
                count > 1 
                ? Column(
                  children: [
                    Text('*$count', style: TextStyles.grey_12_w400),
                    SizedBox(height: 4.h,)
                  ],
                ) 
                : SizedBox.shrink()
              ],
            )
          ],
        ),
        SizedBox(height: 2.h,),
        DottedLine(
          lineThickness: 1.h,
          dashLength: 2.0,
          dashColor: ColorStyles.main_grey,
        ),
        SizedBox(height: 10.h)
      ],
    );
  }
}