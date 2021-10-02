import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_mini_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/promotion_card.dart';


class PromotionDetailsView extends StatelessWidget {
  const PromotionDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Акция', style: Theme.of(context).appBarTheme.titleTextStyle,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 15.h,),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  height: 160.h,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  image: NetworkImage('https://world-sewing-machines.ru/image/cache/catalog/demo/sales/birthday-867x433.jpg'),
                ),
              ),  

              SizedBox(height: 15.h,),

              Text('Получи скидку в честь дня рождения', style: TextStyles.black_16_w700),
              SizedBox(height: 10.h,),
              Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley', style: TextStyles.black_14_w400),
              SizedBox(height: 25.h,),

              Text('Промокод:', style: TextStyles.black_16_w700),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryMiniBtn(
                    text: 'x38Jddq',
                    onTap: (){

                    },
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}