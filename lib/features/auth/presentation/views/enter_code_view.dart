import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/loaders/mini_loader_v1.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/modals/dialog_loading_modal.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_button/timer_button.dart';

class EnterCodeView extends StatefulWidget {
  final String phone;
  EnterCodeView({required this.phone});

  @override
  State<EnterCodeView> createState() => _EnterCodeViewState();
}

class _EnterCodeViewState extends State<EnterCodeView> {
  final TextEditingController codeController = new TextEditingController();
  
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: ColorStyles.white,
      body: SafeArea(
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
                  Text('Вход по SMS', style: TextStyles.black_18_w700,),
                  SizedBox(height: 15.h),
                  Text('Мы отправили SMS-код на ${widget.phone} \nвведите его для подтверждения входа', style: TextStyles.grey_14_w400, textAlign: TextAlign.center),

                  SizedBox(height: 30.h),
                  Container(
                    width: 220.w,
                    child: PinFieldAutoFill(
                      keyboardType: TextInputType.number,
                      controller: codeController,
                      decoration: UnderlineDecoration(
                        textStyle: TextStyles.black_26_w500,
                        gapSpace: 12.w,
                        colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                      ),
                      currentCode: '',
                      onCodeSubmitted: (code) {},

                      codeLength: 6,
                    ),
                  ),
                  SizedBox(height: 30.h),

                  TimerButton(
                    label: "Заново отправить код",
                    timeOutInSeconds: 30,
                    onPressed: () {
                      context.read<AuthBloc>().add(SendSMSEvent(phone: widget.phone));
                    },
                    buttonType: ButtonType.TextButton,
                    disabledColor: Color.fromRGBO(0, 0, 0, 0),
                    color: Color.fromRGBO(0, 0, 0, 0),
                    disabledTextStyle: TextStyles.primary_14_w400,
                    activeTextStyle: TextStyles.primary_14_w400.copyWith(fontWeight: FontWeight.bold),
                  ),

                ],
              ),
            ),
            SizedBox(height: 200.h,)
          ],
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5,),
          isLoading
          ? MiniLoaderV1()
          : PrimaryBtn(
            text: 'Продолжить', 
            onTap: (){
              context.read<AuthBloc>().add(SignInEvent(phone: widget.phone, code: codeController.text));  
              setState(() {
                isLoading = true;
              });            
            }
          )
        ],
      ),
    );
  }
}