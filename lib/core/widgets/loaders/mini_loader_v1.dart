import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';


class MiniLoaderV1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.16,
        child: LoadingIndicator(
            indicatorType: Indicator.ballPulse, /// Required, The loading type of the widget
            colors: const [ColorStyles.grey888, ColorStyles.grey888, ColorStyles.grey888,],       /// Optional, The color collections
            strokeWidth: 3.w,                     /// Optional, The stroke of the line, only applicable to widget which contains line
            // backgroundColor: Colors.black,      /// Optional, Background of the widget
            // pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColo
        ),
      ),
    );
  }
}