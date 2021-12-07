import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/helpers/phone_number_helper.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/toasts.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/modals/dialog_loading_modal.dart';
import 'package:shopv1deliveryfood_mobile/features/additions/presentation/views/loading_view.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/get_user_info.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/views/register_view.dart';
import 'package:shopv1deliveryfood_mobile/features/main/presentation/views/main_view.dart';

import 'enter_code_view.dart';


class SplashView extends StatefulWidget {

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(CheckUserLoggedEvent());
  }

  var maskFormatter = MaskTextInputFormatter(mask: '+7 (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });
  final formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state){
        if(state is RequiredGetUserInfoState || state is LoginWithPhoneSuccessState){
          context.read<AuthBloc>().add(GetUserInfoEvent());
        }
        if(state is RequiredCheckState){
          context.read<AuthBloc>().add(CheckUserLoggedEvent());
        }

        if(state is ErrorState){
          showAlertToast(state.message);
          context.read<AuthBloc>().add(CheckUserLoggedEvent());
        }

        if(state is OpenAuthFormState){
          _showSourceTypeModal(context: context);
        }

        if(state is InternetConnectionFailed){
          showAlertToast('Проверьте ваше интернет соединение..');
          context.read<AuthBloc>().add(CheckUserLoggedEvent());
        }

        if(state is LoginCodeSendedSuccessState){
          Navigator.pop(context);
        }
      },
      
      builder: (context, state) {
        
        if(state is LoginCodeSendedSuccessState){
          return EnterCodeView(phone: state.phone!,);
        }
        if(state is CheckedState || state is OpenAuthFormState || state is BlankState || state is ErrorState){
          return MainView();
        }
        if(state is RequiredRegisterState){
          return RegisterView();
        }
        return LoadingView();
      },
    );
  }

  //Modal for login
  _showSourceTypeModal({
    required BuildContext context,
  }) {


    Widget modalSheet = Container(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height*0.66,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 100.h),
              
              Text('Введите ваш номер телефона', style: TextStyles.black_18_w700,),
              SizedBox(height: 14.h),
              Form(
                key: formKey,
                child: TextFormField(
                  validator: (val){
                    return val!.length > 17 ? null : 'Введите номер телефона';
                  },
                  inputFormatters: [maskFormatter],
                  controller: _phoneController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Номер',
                    isDense: true,
             
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: ColorStyles.main_grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              PrimaryBtn(
                text: 'Авторизоваться', 
                onTap: (){
                  if(formKey.currentState!.validate()){
                    String phone = getConvertedNumber(_phoneController.text);
                    print('Formatted phone is: $phone');
                    context.read<AuthBloc>().add(SendSMSEvent(phone: phone));
                    Navigator.pop(context);

                    Dialogs.showLoadingDialog(context);
                  }
                }
              )
            ],
          ),
        )
      ),
    );


  



    // show the dialog
    showMaterialModalBottomSheet(
      elevation: 6,
      duration: Duration(milliseconds: 300),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )
      ),
      builder: (BuildContext context) {
        return modalSheet;
      },
    );
  }
}


class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MainView()));
        },
        child: Center(
          child: Text('Logo', style: TextStyles.black_28_w700,)
        ),
      ),
    );
  }
}