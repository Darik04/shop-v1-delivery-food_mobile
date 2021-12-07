part of 'main_screen_bloc.dart';

class MainScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class ChangeViewEvent extends MainScreenEvent{
  final int view;
  ChangeViewEvent({required this.view});
}