import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/toasts.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state){
        if(state is RequiredGetUserInfoState || state is LoginWithPhoneSuccessState){
          context.read<AuthBloc>().add(GetUserInfoEvent());
        }

        if(state is ErrorState){
          showAlertToast(state.message);
        }
      },
      
      builder: (context, state) {
        if(state is LoginCodeSendedSuccessState){
          return EnterCodeView(phone: state.phone!,);
        }
        if(state is CheckedState){
          return MainView();
        }
        if(state is RequiredRegisterState){
          return RegisterView();
        }
        return SplashWidget();
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