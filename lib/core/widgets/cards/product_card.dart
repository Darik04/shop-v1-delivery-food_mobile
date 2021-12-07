import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/helpers/truncate_text_helper.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/product_to_cart_mini_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/product_to_cart_mini_with_counter_btn.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';

import '../../../locator.dart';


class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;
  final Function() onTap;
  final Function() addToFavoritesTap;
  final Function() addToCartTap;
  final Function() removeFromCartTap;
  const ProductCard({
    required this.productEntity,
    required this.onTap,
    required this.addToCartTap,
    required this.addToFavoritesTap,
    required this.removeFromCartTap,
  }) : super();

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))
          ],
          borderRadius: BorderRadius.circular(5),
          color: ColorStyles.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5),),
                  child: productEntity.photo == null || productEntity.photo == ''
                  ? Image(
                    fit: BoxFit.cover,
                    height: 170.h,
                    width: MediaQuery.of(context).size.width,
                    image: AssetImage('assets/images/user.png'),
                  ) 
                  : Image(
                    fit: BoxFit.cover,
                    height: 170.h,
                    width: MediaQuery.of(context).size.width,
                    image: NetworkImage(productEntity.photo),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: addToFavoritesTap,
                    child: Icon(
                      productEntity.countInFavorite == 0
                      ? Icons.star_border_outlined
                      : Icons.star,
                      color: ColorStyles.yellow_accent,
                      size: 32
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(productEntity.title, style: TextStyles.black_16_w700),
                      Text('22 / 22', style: TextStyles.grey_12_w700),

                    ],
                  ),
                  SizedBox(height: 3.h,),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Text(truncateWithEllipsis(44, productEntity.description), style: TextStyles.black_14_w400,),
                  ),
                  SizedBox(height: 6.h,),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      productEntity.countInCart == 0
                      ? ProductToCartMiniBtn(
                        text: 'В корзину',
                        onTap: addToCartTap
                      )
                      : ProductToCartMiniWithCounterBtn(
                        count: productEntity.countInCart, 
                        onAdd: addToCartTap, 
                        onRemove: removeFromCartTap,
                        maxCount: productEntity.maxCountInCart
                      ),
                      Text('${productEntity.price} ₸', style: TextStyles.green_18_w700),

                    ],
                  )
                ],
              ),
            )
          ],
        
        )
      ),
    );
  }
}