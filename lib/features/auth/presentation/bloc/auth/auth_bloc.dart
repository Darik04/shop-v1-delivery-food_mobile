import 'dart:async';
import 'dart:io';
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
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/register.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/send_sms.dart';

import '../../../../../locator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendSMS sendSMS;
  final AuthSignIn authSignIn;
  final GetUserInfo getUserInfo;
  final GetTokenLocal getTokenLocal;
  final Register register;
  final Logout logout;
  
  AuthBloc(this.sendSMS, this.authSignIn,  this.getUserInfo,  this.getTokenLocal, this.logout, this.register) : super(InitialState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    if(event is CheckUserLoggedEvent){
      var token = await getTokenLocal(NoParams());
      yield token.fold(
        (failure){
          if(failure == ConnectionFailure())
            return InternetConnectionFailed();
          else if(failure is ServerFailure)
            return ErrorState(message: failure.message);
          else
            return ErrorState(message: 'Повторите попытку');
        },
        (token){
          if(token != null){
            sl<AuthConfig>().token = token;
            print('required get user info');
            return RequiredGetUserInfoState();
          }else{
            print('USER IS NOT LOGGED');
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
          print('FAIL: ${failure}');
          if(failure == ConnectionFailure())
            return InternetConnectionFailed();
          else if(failure is ServerFailure)
            return ErrorState(message: failure.message);
          else
            return ErrorState(message: 'Повторите попытку');
          
        },
        (isSuccess){
          print('SUCCESS: ${isSuccess}');
          return LoginCodeSendedSuccessState(code: isSuccess, phone: event.phone);
        }
      );

    }

    if(event is SignInEvent){
      print('SignInEvent in bloc');
      var authGetToken = await authSignIn(AuthSignParams(phoneNumber: event.phone, code: event.code));
      yield authGetToken.fold(
        (failure) {
          if(failure is ConnectionFailure)
            return InternetConnectionFailed();
          else if(failure is ServerFailure)
            return ErrorState(message: failure.message);
          else 
            return ErrorState(message: 'Не смогли зайти');
        },
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
        (failure) {
          print('FAILURE: ${failure}');
          if(failure == ConnectionFailure())
            return InternetConnectionFailed();
          else if(failure is ServerFailure)
            return ErrorState(message: failure.message);
          else
            return ErrorState(message: 'Повторите попытку');
        },
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


    if(event is OpenAuthFormEvent){
      yield BlankState();
      yield OpenAuthFormState();
    }

    if(event is RegisterEvent){
      print('RegisterEvent in bloc');
      var registerResult = await register(RegisterParams(
        cityId: event.cityId, 
        phoneNumber: event.phone, 
        lastName: event.lastName, 
        firstName: event.firstName,
        avatar: event.avatar
      ));
      yield registerResult.fold(
        (failure) {
          if(failure == ConnectionFailure())
            return InternetConnectionFailed();
          else if(failure is ServerFailure)
            return ErrorState(message: failure.message);
          else
            return ErrorState(message: 'Не смогли зарегестрировать');
        },
        (bool isRegister) {
          if(isRegister){
            return RequiredGetUserInfoState();
          }else{
            return ErrorState(message: 'Не смогли зарегестрировать');
          }
        }
        
      );
      
    }








    if(event is LogoutEvent){
      print('LogoutEvent in bloc');
      var logoutResult = await logout(NoParams());
      yield logoutResult.fold(
        (failure) {
          if(failure is ConnectionFailure)
            return InternetConnectionFailed();
          else
            return ErrorState(message: 'Не смогли выйти');
        },
        (bool isExited) {
          
          sl<AuthConfig>().phone = null;
          sl<AuthConfig>().userEntity = null;
          sl<AuthConfig>().token = null;
          sl<AuthConfig>().authenticatedOption = AuthenticatedOption.unauthenticated;
          return RequiredCheckState();
          
        }
        
      );
      
    }
    
  }

}
