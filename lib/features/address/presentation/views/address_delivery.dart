import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';

class DeliveryAddressView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Адрес доставки', style: Theme.of(context).appBarTheme.titleTextStyle,)
      ),
      body: Column(
        children: [
          Container(
            width: _width,
            height: 230.h,
            color: ColorStyles.main_grey,
          ),
          Container(
            width: _width,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            color: ColorStyles.green_accent,
            alignment: Alignment.center,
            child: Text('Потяните карту, чтобы выбрать адрес', style: TextStyles.white_16_w400,),
          ),

          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Город',
                    labelStyle: TextStyles.grey_14_w400,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w))
                  ),
                  enabled: true,
                  
                  style: TextStyles.black_16_w700,
                ),
                SizedBox(height: 5.h,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Улица',
                    labelStyle: TextStyles.grey_14_w400,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w))
                  ),
                  enabled: true,
                  
                  style: TextStyles.black_14_w400,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Дом',
                          labelStyle: TextStyles.grey_14_w400,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w))
                        ),
                        enabled: true,
                        
                        style: TextStyles.black_14_w400,
                      ),
                    ),
                    SizedBox(width: 30.w),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Подъезд',
                          labelStyle: TextStyles.grey_14_w400,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w))
                        ),
                        enabled: true,
                        
                        style: TextStyles.black_14_w400,
                      ),
                    ),
                    SizedBox(width: 30.w),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Квартира',
                          labelStyle: TextStyles.grey_14_w400,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w))
                        ),
                        enabled: true,
                        
                        style: TextStyles.black_14_w400,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 30.h,),
          PrimaryBtn(
            text: 'Применить',
            onTap: (){

            }
          )
        ],
      ),
    );
  }
}