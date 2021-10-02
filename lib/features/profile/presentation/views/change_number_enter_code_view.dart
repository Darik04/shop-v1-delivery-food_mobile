import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/views/register_view.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ChangeNumberEnterCodeView extends StatelessWidget {
  const ChangeNumberEnterCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Смена номера', style: Theme.of(context).appBarTheme.titleTextStyle,),
      ),
      backgroundColor: ColorStyles.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.h,),
          Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Введите код из SMS', style: TextStyles.black_18_w700,),
                SizedBox(height: 15.h),
                Text('Мы отправили SMS-код на +7 (700) 323-32-34 \nвведите его для подтверждения', style: TextStyles.grey_14_w400, textAlign: TextAlign.center),

                SizedBox(height: 30.h),
                Container(
                  width: 220.w,
                  child: PinFieldAutoFill(
                    decoration: UnderlineDecoration(
                      textStyle: TextStyles.black_26_w500,
                      gapSpace: 12.w,
                      colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                    ),
                    currentCode: '',
                    onCodeSubmitted: (code) {},
                    // onCodeChanged: (code) {
                    //   if (code!.length == 4) {
                    //     context.read<LoginBloc>().add(SignInEvent(phone: widget.phone, code: _codeController.text.trim(), userMode: userMode));
                    //     Dialogs.showLoadingDialog(context);
                    //   }
                    // },

                    codeLength: 6,
                  ),
                ),
                SizedBox(height: 30.h),


                Text('Получить код повторно через 30 сек', style: TextStyles.primary_14_w400, textAlign: TextAlign.center),

              ],
            ),
          ),
          SizedBox(height: 200.h,)
        ],
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 5,),
          PrimaryBtn(
            text: 'Применить', 
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RegisterView()));
              
            }
          )
        ],
      ),
    );
  }
}