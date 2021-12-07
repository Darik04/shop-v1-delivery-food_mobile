import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/enums/sort_enum.dart';
part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  
  MainScreenBloc() : super(MainScreenChangedState(currentView: 0));

  int currentView = 0;

  @override
  Stream<MainScreenState> mapEventToState(MainScreenEvent event) async*{
    
    if(event is ChangeViewEvent){
      yield MainScreenBlankState();
      currentView = event.view;
      yield MainScreenChangedState(currentView: currentView);
    }

    
  }

}
