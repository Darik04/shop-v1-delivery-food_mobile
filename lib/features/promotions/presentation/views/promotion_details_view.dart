import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_mini_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/promotion_card.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/entities/promotion_entity.dart';


class PromotionDetailsView extends StatelessWidget {
  final PromotionEntity promotion;
  const PromotionDetailsView({Key? key, required this.promotion}) : super(key: key);

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
                child: promotion.image == null
                ? Image(
                  height: 160.h,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/user.png')
                )
                : Image(
                  height: 160.h,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  image: NetworkImage(promotion.image!)
                ),
              ),  

              SizedBox(height: 15.h,),

              Text(promotion.title, style: TextStyles.black_16_w700),
              SizedBox(height: 10.h,),
              Text(promotion.description, style: TextStyles.black_14_w400),
              SizedBox(height: 25.h,),

              Text('Промокод:', style: TextStyles.black_16_w700),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryMiniBtn(
                    text: promotion.promoCode!,
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