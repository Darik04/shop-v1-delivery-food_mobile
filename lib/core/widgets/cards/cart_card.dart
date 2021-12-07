import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/helpers/truncate_text_helper.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/product_count_in_cart_mini_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/product_to_cart_mini_with_counter_btn.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';


class CartCard extends StatelessWidget {
  final bool isLast;
  final ProductEntity productEntity;
  final Function() onTap;
      final Function() addToCartTap;
  final Function() removeFromCartTap;
  const CartCard({
    Key? key, 
    required this.isLast, 
    required this.productEntity,
    required this.onTap,
    required this.addToCartTap,
    required this.removeFromCartTap,
  }) : super(key: key);

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
                child: productEntity.photo == null || productEntity.photo == ''
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
                  image: NetworkImage(productEntity.photo),
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
                      Text(productEntity.title, style: TextStyles.black_16_w700,),
                      SizedBox(height: 3.h,),
                      Text(truncateWithEllipsis(72, productEntity.description), style: TextStyles.grey_16_w400,),
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ProductCountInCartMiniBtn(
                          //   text: 'test',
                          //   onTap: (){},
                          // ),
                          ProductToCartMiniWithCounterBtn(
                            onAdd: addToCartTap,
                            onRemove: removeFromCartTap,
                            count: productEntity.countInCart,
                            maxCount: productEntity.maxCountInCart,
                          ),

                          Text('${productEntity.price} ₸', style: TextStyles.green_18_w700,)
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