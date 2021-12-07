import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/usecases/usecase.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/entities/city_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/usecases/get_cities.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/token_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/auth_signin.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/get_token_local.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/get_user_info.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/logout.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/send_sms.dart';

import '../../../../../locator.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final GetAllCities getAllCities;
  CityBloc(this.getAllCities) : super(InitialState());

  @override
  Stream<CityState> mapEventToState(CityEvent event) async*{


    if(event is GetAllCitiesEvent){
      yield LoadingState();
      
      var gotAllCities = await getAllCities(NoParams());
      yield gotAllCities.fold(
        (failure){
          if(failure == ConnectionFailure()){
            return ErrorState(message: 'Проверьте интернет соединение');
          }else{
            return ErrorState(message: 'Ошибка сервера');
          }
        },
        (cities){
          return SuccessGotAllCitiesState(cities: cities);
        }
      );

    }



    
    


    
  }

}
