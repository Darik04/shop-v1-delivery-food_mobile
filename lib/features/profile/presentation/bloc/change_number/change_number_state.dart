part of 'change_number_bloc.dart';

class ChangeNumberState extends Equatable {
  const ChangeNumberState();
  @override
  List<Object> get props => [];
}

class ChangeNumberInitialState extends ChangeNumberState {}
class ChangeNumberLoadingState extends ChangeNumberState {}
class ChangeNumberErrorState extends ChangeNumberState {
  final String message;
  ChangeNumberErrorState({required this.message});
}
class InternetConnectionFailureState extends ChangeNumberState {}

class SMSSendedSuccessState extends ChangeNumberState{
  final bool isResend;
  SMSSendedSuccessState({required this.isResend});
}
class SMSGotSuccessState extends ChangeNumberState{}
class SMSCheckedSuccessState extends ChangeNumberState{}
