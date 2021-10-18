import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/product_count_in_cart_mini_btn.dart';


class CartCard extends StatelessWidget {
  final bool isLast;
  const CartCard({Key? key, required this.isLast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 14.h),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: true
                ? Image(
                  width: 104.w,
                  height: 135.h,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/user.png'),
                )
                : Image(
                  width: 104.w,
                  height: 135.h,
                  fit: BoxFit.cover,
                  image: NetworkImage('https://restolife.kz/upload/information_system_6/2/3/2/item_23259/information_items_property_28042.jpg'),
                ),
              ),
              SizedBox(width: 10,),
              Flexible(
                
                child: Container(
                  height: 135.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Чикен Чизбургер BBQ', style: TextStyles.black_16_w700,),
                      Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has.', style: TextStyles.grey_16_w400,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProductCountInCartMiniBtn(
                            text: 'test',
                            onTap: (){},
                          ),


                          Text('1500 тг.', style: TextStyles.green_18_w700,)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

        !isLast
        ? Container(
          width: MediaQuery.of(context).size.width,
          height: 1.h,
          color: ColorStyles.middle_grey,
          margin: EdgeInsets.only(bottom: 14.h),
        )
        : SizedBox.shrink()
      ],
    );
  }
}