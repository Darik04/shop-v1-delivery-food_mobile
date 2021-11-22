import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/helpers/phone_number_helper.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/toasts.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/modals/dialog_loading_modal.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/views/register_view.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/presentation/bloc/change_number/change_number_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../locator.dart';
import 'change_number_enter_code_view.dart';

class ChangeNumberEnterPhoneView extends StatelessWidget {
  var maskFormatter = MaskTextInputFormatter(mask: '+7 (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });
  final formKey = GlobalKey<FormState>();

  TextEditingController newPhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Смена номера', style: Theme.of(context).appBarTheme.titleTextStyle,),
      ),
      backgroundColor: ColorStyles.white,
      body: BlocConsumer<ChangeNumberBloc, ChangeNumberState>(
        listener: (context, state){
          if(state is SMSSendedSuccessState){
            if(!state.isResend){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChangeNumberEnterCodeView(phone: newPhoneController.text,)));
            }
            
          }
          if(state is ChangeNumberErrorState){
            Navigator.pop(context);
            showAlertToast(state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h,),
                Container(
                  alignment: Alignment.center,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Введите новый номер телефона', style: TextStyles.black_18_w700,),
                        SizedBox(height: 20.h),

                        TextFormField(
                          inputFormatters: [maskFormatter],
                          textCapitalization: TextCapitalization.sentences,
                          controller: newPhoneController,
                          decoration: InputDecoration(
                            hintText: 'Новый номер',
                            isDense: true,
                          
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: ColorStyles.main_grey),
                            ),
                          ),
                          validator: (val){
                            if(val!.length < 17 || val == null){
                              return 'Введите номер телефона';
                            }
                            if(sl<AuthConfig>().userEntity!.phone == getConvertedNumber(val)){
                              return 'Введите новый номер';    
                            }
                          },
                        ),
                        
                        SizedBox(height: 12.h),

                        Text('На введенный номер придет SMS-код', style: TextStyles.grey_14_w400,),



                      ],
                    ),
                  ),
                ),
                SizedBox(height: 200.h,)
              ],
            ),
          );
        }
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 5,),
          PrimaryBtn(
            text: 'Продолжить', 
            onTap: (){
              if(formKey.currentState!.validate()){
                context.read<ChangeNumberBloc>().add(SendSMSForChangePhoneEvent(newPhone: getConvertedNumber(newPhoneController.text), isResend: false));
                Dialogs.showLoadingDialog(context);
              }
              
            }
          )
        ],
      ),
    );
  }
}