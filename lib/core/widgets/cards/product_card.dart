import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/product_to_cart_mini_btn.dart';


class ProductCard extends StatelessWidget {
  final String url;
  final String title;
  final String description;
  final String firstArgument;
  final String secondArgument;
  final int price;
  final Function() onTap;
  const ProductCard({
    required this.url,
    required this.onTap, 
    required this.price,
    required this.title,
    required this.description,
    required this.firstArgument,
    required this.secondArgument,
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
                  child: url == null || url == ''
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
                    image: NetworkImage(url),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: (){},
                    child: Icon(
                      Icons.star_border_outlined,
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
                      Text(title, style: TextStyles.black_16_w700),
                      Text('$firstArgument / $secondArgument', style: TextStyles.grey_12_w700),

                    ],
                  ),
                  SizedBox(height: 3.h,),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Text(description, style: TextStyles.black_14_w400,),
                  ),
                  SizedBox(height: 6.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductToCartMiniBtn(
                        text: 'test',
                        onTap: (){},
                      ),
                      Text('$price ₸', style: TextStyles.green_18_w700),

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