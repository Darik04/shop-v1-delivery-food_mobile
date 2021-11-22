import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/usecases/send_code_for_change_phone.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/usecases/update_phone.dart';
part 'change_number_event.dart';
part 'change_number_state.dart';

class ChangeNumberBloc extends Bloc<ChangeNumberEvent, ChangeNumberState>{
  final SendCodeForChangePhone sendCodeForChangePhone; 
  final UpdatePhoneNumber updatePhoneNumber; 
  
  ChangeNumberBloc(this.sendCodeForChangePhone, this.updatePhoneNumber) : super(ChangeNumberInitialState());

  @override
  Stream<ChangeNumberState> mapEventToState(ChangeNumberEvent event) async*{
    if(event is SendSMSForChangePhoneEvent){
      yield ChangeNumberLoadingState();
      var success = await sendCodeForChangePhone(SendCodeForChangePhoneParams(newPhone: event.newPhone));
      //Folding sending sms
      yield success.fold(
        (failure){
          print('ERROR: ${failure}');
          if(failure is ConnectionFailure){
            return InternetConnectionFailureState();
          }
          if(failure is ServerFailure){
            return ChangeNumberErrorState(message: failure.message);

          }
          return ChangeNumberErrorState(message: 'Не смогли загрузить обновить');
        },
        (promos){
          return SMSSendedSuccessState(isResend: event.isResend);
        }
      );
    }


    if(event is UpdatePhoneEvent){
      yield ChangeNumberLoadingState();
      var success = await updatePhoneNumber(UpdatePhoneNumberParams(code: event.code));
      //Folding updating
      yield success.fold(
        (failure){
          print('ERROR: ${failure}');
          if(failure is ConnectionFailure){
            return InternetConnectionFailureState();
          }
          if(failure is ServerFailure){
            return ChangeNumberErrorState(message: failure.message);

          }
          return ChangeNumberErrorState(message: 'Не смогли загрузить обновить');
        },
        (promos){
          return SMSCheckedSuccessState();
        }
      );
    }


    
  }

}
