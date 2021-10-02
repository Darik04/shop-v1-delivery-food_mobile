import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/views/register_view.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'change_number_enter_code_view.dart';

class ChangeNumberEnterPhoneView extends StatelessWidget {
  const ChangeNumberEnterPhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Смена номера', style: Theme.of(context).appBarTheme.titleTextStyle,),
      ),
      backgroundColor: ColorStyles.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h,),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Введите новый номер телефона', style: TextStyles.black_18_w700,),
                  SizedBox(height: 20.h),

                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: 'Новый номер',
                      isDense: true,
                
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorStyles.main_grey),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 12.h),

                  Text('На введенный номер придет SMS-код', style: TextStyles.grey_14_w400,),



                ],
              ),
            ),
            SizedBox(height: 200.h,)
          ],
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 5,),
          PrimaryBtn(
            text: 'Продолжить', 
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChangeNumberEnterCodeView()));
              
            }
          )
        ],
      ),
    );
  }
}