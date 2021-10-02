import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/shadow_primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/promotion_card.dart';
import 'package:shopv1deliveryfood_mobile/features/address/presentation/views/address_delivery.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/presentation/views/promotion_details_view.dart';

import 'order_enter_code_view.dart';


class OrderCreateView extends StatelessWidget {
  const OrderCreateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Оформление заказа', style: Theme.of(context).appBarTheme.titleTextStyle,),
      ),
      backgroundColor: ColorStyles.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 20.h,),

              // Delivery address
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 20,
                    color: ColorStyles.primary,
                  ),
                  SizedBox(width: 10.w,),
                  Text('Адрес доставки', style: TextStyles.black_18_w700,)

                ],
              ),
              SizedBox(height: 12.h,),

              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DeliveryAddressView()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Караганда, ул. Карла Маркса, дом 6', style: TextStyles.grey_14_w400,),
                    Icon(
                      Icons.create_outlined,
                      size: 22,
                      color: ColorStyles.main_grey
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h,),
              DottedLine(
                lineThickness: 1.h,
                dashLength: 2.0,
                dashColor: ColorStyles.main_grey,
              ),


              SizedBox(height: 20.h,),
              // Contact info
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 20,
                    color: ColorStyles.primary,
                  ),
                  SizedBox(width: 10.w,),
                  Text('Контактные данные', style: TextStyles.black_18_w700,)

                ],
              ),
              SizedBox(height: 4.h,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Имя',
                  labelText: 'Ваше имя',
                  labelStyle: TextStyles.grey_14_w400,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w))
                ),
                
                style: TextStyles.black_14_w400,
              ),

              TextFormField(
                decoration: InputDecoration(
                  hintText: '+7',
                  labelText: 'Номер',
                  labelStyle: TextStyles.grey_14_w400,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w))
                ),
                
                style: TextStyles.black_14_w400,
              ),


              SizedBox(height: 20.h,),
              // Payment method
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 20,
                    color: ColorStyles.primary,
                  ),
                  SizedBox(width: 10.w,),
                  Text('Тип оплаты', style: TextStyles.black_18_w700,)

                ],
              ),
              SizedBox(height: 12.h,),
              Row(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            width: 4.w, 
                            color: true ? ColorStyles.green_accent : ColorStyles.middle_grey
                          )
                        ),
                      ),
                      SizedBox(width: 6.w,),
                      Text('Наличными', style: TextStyles.grey_14_w400,)
                    ],
                  ),
                  SizedBox(width: 14.w,),

                  Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            width: 4.w, 
                            color: false ? ColorStyles.green_accent : ColorStyles.middle_grey
                          )
                        ),
                      ),
                      SizedBox(width: 6.w,),
                      Text('Картой', style: TextStyles.grey_14_w400,)
                    ],
                  ),
                ],
              ),

              SizedBox(height: 8.h,),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Сдача c',
                  labelStyle: TextStyles.grey_14_w400,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w))
                ),
                
                style: TextStyles.black_14_w400,
              ),
              SizedBox(height: 8.h,),
              
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Комментарий к заказу',
                  labelText: 'Коммент',
                  labelStyle: TextStyles.grey_14_w400,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w))
                ),
                
                style: TextStyles.black_14_w400,
              ),

              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Если есть введите промокод',
                  labelText: 'Промокод',
                  labelStyle: TextStyles.grey_14_w400,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w))
                ),
                
                style: TextStyles.black_14_w400,
              ),
              SizedBox(height: 22.h,),
              
              Row(
                children: [
                  SizedBox(width: 2.w),
                  
                  GestureDetector(
                    onTap: (){},
                    child: true
                    ? Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: ColorStyles.main_grey),
                        borderRadius: BorderRadius.circular(3)
                      )
                    )
                    : Icon(
                      Icons.check,
                      size: 20,
                      color: ColorStyles.green_accent
                    )
                  ),
                  SizedBox(width: 10.w),
                  Text.rich(
                    TextSpan(
                      text: 'Я принимаю условия ',
                      style: TextStyles.black_14_w400,
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'соглашения',
                          style: TextStyles.green_14_w700,
                        )
                      ]
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),


      floatingActionButton: true 
      ? Column(
        mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadowPrimaryBtn(
            text: 'Оформить заказ на: 8000 тг.',
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OrderEnterCodeView()));
            },
            paddingV: 22.h,
          ),
        ],
      )
      : SizedBox.shrink()
    );
  }
}