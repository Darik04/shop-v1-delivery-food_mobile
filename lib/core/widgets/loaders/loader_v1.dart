import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';


class LoaderV1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.45,
        child: LoadingIndicator(
            indicatorType: Indicator.ballPulse, /// Required, The loading type of the widget
            colors: const [ColorStyles.green_accent, ColorStyles.primary, ColorStyles.yellow_accent],       /// Optional, The color collections
            strokeWidth: 5.w,                     /// Optional, The stroke of the line, only applicable to widget which contains line
            // backgroundColor: Colors.black,      /// Optional, Background of the widget
            // pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColo
        ),
      ),
    );
  }
}