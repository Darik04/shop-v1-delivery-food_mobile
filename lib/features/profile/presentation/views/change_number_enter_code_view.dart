import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/toasts.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/modals/dialog_loading_modal.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/presentation/bloc/change_number/change_number_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ChangeNumberEnterCodeView extends StatefulWidget {
  final String phone;
  ChangeNumberEnterCodeView({required this.phone});

  @override
  State<ChangeNumberEnterCodeView> createState() => _ChangeNumberEnterCodeViewState();
}

class _ChangeNumberEnterCodeViewState extends State<ChangeNumberEnterCodeView> {
  TextEditingController codeController = TextEditingController();

  //Timer for resend
  Timer? _timer;
  int _start = 0;

  void startTimer() {
    _start = 3;
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(() {
        if (_start == 0) {
          timer.cancel();
        } else {
          _start--;
        }
      })
    );
  } 
  
  
  @override
  void dispose() {
    if(_timer != null && _timer!.isActive){
      _timer!.cancel();
    }
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Смена номера', style: Theme.of(context).appBarTheme.titleTextStyle,),
      ),
      backgroundColor: ColorStyles.white,
      body: BlocConsumer<ChangeNumberBloc, ChangeNumberState>(
        listener: (context, state){
          if(state is SMSCheckedSuccessState){
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            context.read<AuthBloc>().add(CheckUserLoggedEvent());
          }
          if(state is ChangeNumberErrorState){
            // Navigator.pop(context);
            showAlertToast(state.message);
          }
        },
        builder: (context, state) {
          return Column(
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
                    Text('Мы отправили SMS-код на ${widget.phone} \nвведите его для подтверждения', style: TextStyles.grey_14_w400, textAlign: TextAlign.center),

                    SizedBox(height: 30.h),
                    Container(
                      width: 220.w,
                      child: PinFieldAutoFill(
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

                    _start == 0
                    ? Text.rich(
                    
                    TextSpan(
                        
                        text: 'Отправить код заново ',
                        
                        style: TextStyles.primary_14_w400,
                        
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'отправить',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                startTimer();
                                context.read<ChangeNumberBloc>().add(SendSMSForChangePhoneEvent(newPhone: widget.phone, isResend: true));
                              },
                          )
                        ]
                      ),
                      textAlign: TextAlign.center,
                    )
                    : Text('Получить код повторно через $_start сек', style: TextStyles.primary_14_w400, textAlign: TextAlign.center),

                  ],
                ),
              ),
              SizedBox(height: 200.h,)
            ],
          );
        }
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 5,),
          PrimaryBtn(
            text: 'Применить', 
            onTap: (){
              context.read<ChangeNumberBloc>().add(UpdatePhoneEvent(code: int.parse(codeController.text)));          
              Dialogs.showLoadingDialog(context); 
            }
          )
        ],
      ),
    );
  }
}