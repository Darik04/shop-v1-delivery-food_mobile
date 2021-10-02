import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';


class DottedLineCustom extends StatelessWidget {
  final String title;
  final String content;
  const DottedLineCustom({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Вес:', style: TextStyles.black_14_w400,),
            Text('556 г ', style: TextStyles.grey_14_w400,),
          ],
        ),
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