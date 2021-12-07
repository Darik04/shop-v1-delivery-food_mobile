part of 'main_screen_bloc.dart';

class MainScreenState extends Equatable {
  const MainScreenState();
  @override
  List<Object> get props => [];
}

class MainScreenInitialState extends MainScreenState {}
class MainScreenBlankState extends MainScreenState {}
class MainScreenChangedState extends MainScreenState {
  final int currentView;
  MainScreenChangedState({required this.currentView});
}
