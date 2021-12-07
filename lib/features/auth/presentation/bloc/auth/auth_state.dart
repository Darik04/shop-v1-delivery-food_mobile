part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class InitialState extends AuthState {}


class LoginCodeSendedSuccessState extends AuthState{
  final String? phone;
  final String? code;
  LoginCodeSendedSuccessState({this.phone, this.code});
}


class LoginWithPhoneSuccessState extends AuthState{}

class RequiredRegisterState extends AuthState{}
class RequiredCheckState extends AuthState{}
class RequiredGetUserInfoState extends AuthState{}

class InternetConnectionFailed extends AuthState{}

class CheckedState extends AuthState{}
class OpenAuthFormState extends AuthState{}
class BlankState extends AuthState{}
class ErrorState extends AuthState{
  final String message;
  ErrorState({required this.message});
}