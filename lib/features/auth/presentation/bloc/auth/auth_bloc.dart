import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/token_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/auth_signin.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/get_token_local.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/get_user_info.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/logout.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/send_sms.dart';

import '../../../../../locator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendSMS sendSMS;
  final AuthSignIn authSignIn;
  final GetUserInfo getUserInfo;
  final GetTokenLocal getTokenLocal;
  final Logout logout;
  
  AuthBloc(this.sendSMS, this.authSignIn,  this.getUserInfo,  this.getTokenLocal, this.logout) : super(InitialState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    if(event is CheckUserLoggedEvent){
      var token = await getTokenLocal(NoParams());
      yield token.fold(
        (failure){
          return ErrorState(message: 'Повторите попытку');
        },
        (token){
          if(token != null){
            sl<AuthConfig>().token = token;
            print('required get user info');
            return RequiredGetUserInfoState();
          }else{
            sl<AuthConfig>().token = null;
            return CheckedState();
          }
        }
      );

    }

    if(event is SendSMSEvent){
      var sendedSMSOrFail = await sendSMS(PhoneParams(phoneNumber: event.phone));
      yield sendedSMSOrFail.fold(
        (failure){
          if(failure == ConnectionFailure()){
            return ErrorState(message: 'Проверьте интернет соединение');
          }else{
            return ErrorState(message: 'Повторите попытку');
          }
        },
        (isSuccess){
          return LoginCodeSendedSuccessState(code: isSuccess, phone: event.phone);
        }
      );

    }

    if(event is SignInEvent){
      print('SignInEvent in bloc');
      var authGetToken = await authSignIn(AuthSignParams(phoneNumber: event.phone, code: event.code));
      yield authGetToken.fold(
        (failure) => ErrorState(message: 'Не смогли зайти'),
        (TokenEntity tokenEntity) {
          sl<AuthConfig>().phone = event.phone;
          sl<AuthConfig>().token = tokenEntity.token;
          if(tokenEntity.registered){
            return LoginWithPhoneSuccessState();
          }else{
            return RequiredRegisterState();
          }
        }
        
      );
      
    }


    if(event is GetUserInfoEvent){
      print('Get user info in bloc');
      var gotUserInfo = await getUserInfo(NoParams());
      yield gotUserInfo.fold(
        (failure) => ErrorState(message: 'Не смогли получить пользователя'),
        (userEntity) {
          if(userEntity.firstName == 'unauthorized' && userEntity.city == null){
            print('Token error logout');
            logout(NoParams());
            sl<AuthConfig>().token = null;
            sl<AuthConfig>().phone = null;
            sl<AuthConfig>().userEntity = null;
            sl<AuthConfig>().authenticatedOption = AuthenticatedOption.unauthenticated;
            return CheckedState();

          }
          sl<AuthConfig>().phone = userEntity.phone;
          if(!userEntity.registered){
            print(userEntity.phone);
            return RequiredRegisterState();
          }
          sl<AuthConfig>().userEntity = userEntity;
          sl<AuthConfig>().authenticatedOption = AuthenticatedOption.authenticated;
          return CheckedState();
        }
        
      );
      
    }

    


    
  }

}
