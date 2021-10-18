import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/shadow_primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/product_card.dart';
import 'package:shopv1deliveryfood_mobile/features/home/presentation/widgets/head_carousel.dart';
import 'package:shopv1deliveryfood_mobile/features/product_details/presentation/widgets/dotted_line.dart';
import 'package:shopv1deliveryfood_mobile/features/product_details/presentation/widgets/head_product_carousel.dart';

class ProductDetailsView extends StatefulWidget {
  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int _currentSliderIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Бургер', style: Theme.of(context).appBarTheme.titleTextStyle,),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadProductCarousel(urls: ['', '', ''],),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h,),
                  Text('Чикен Чизбургер BBQ', style: TextStyles.black_16_w700,),
                  SizedBox(height: 10.h,),
                  Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book', style: TextStyles.grey_14_w400,),

                  SizedBox(height: 15.h,),
                  Text('Особенности:', style: TextStyles.black_16_w700,),
                  SizedBox(height: 10.h,),
                  
                  DottedLineCustom(
                    title: 'Вес:',
                    content: '56 г ',
                  ),
                  DottedLineCustom(
                    title: 'Высота: ',
                    content: '30 см ',
                  ),
                  DottedLineCustom(
                    title: 'Начинка:',
                    content: 'Соус ',
                  ),
                  DottedLineCustom(
                    title: 'Вес:',
                    content: '56 г ',
                  ),

                  SizedBox(height: 15.h,),
                  Row(
                    children: [
                      Text('Цена:', style: TextStyles.black_16_w700,),
                      SizedBox(width: 10.w,),
                      Text('2500 тг.', style: TextStyles.green_18_w700,),

                    ],
                  ),
                  SizedBox(height: 20.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: ColorStyles.main_grey,
                        width: MediaQuery.of(context).size.width*0.88,
                        height: 1.h,
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h,),
                  Text('С этим также покупают', style: TextStyles.black_16_w700,),
                  SizedBox(height: 10.h,),
                  ProductCard(
                    url: '',
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetailsView()));
                    },
                  ),
                  ProductCard(
                    url: '',
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetailsView()));
                    },
                  ),
                ],
              ),
            )
          ],
        )
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 5.h,),
          ShadowPrimaryBtn(
            text: 'В корзину',
            paddingV: 15.h,
            onTap: (){},
          ),
        ],
      ),
    );
  }
}