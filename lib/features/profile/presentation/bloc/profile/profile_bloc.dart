import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/usecases/update_user_info.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  final UpdateUserInfo updateUserInfo; 
  
  ProfileBloc(this.updateUserInfo) : super(ProfileInitialState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async*{
    if(event is UpdateUserInfoEvent){
      yield ProfileLoadingState();
      var success = await updateUserInfo(UpdateUserInfoParams(firstName: event.firstName, lastName: event.lastName, avatar: event.avatar, cityId: event.cityId));
      //Folding updating
      yield success.fold(
        (failure){
          print('ERROR: ${failure}');
          if(failure is ConnectionFailure){
            return InternetConnectionFailureState();
          }
          return ProfileErrorState(message: 'Не смогли загрузить обновить');
        },
        (promos){
          return ChangedSuccessState();
        }
      );
    }


    
  }

}
