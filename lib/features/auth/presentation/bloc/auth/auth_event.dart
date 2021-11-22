part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LogoutEvent extends AuthEvent {}
class CheckUserLoggedEvent extends AuthEvent {}
class GetUserInfoEvent extends AuthEvent {}

class OpenAuthFormEvent extends AuthEvent {}


class SendSMSEvent extends AuthEvent {
  final String phone;
  SendSMSEvent({required this.phone});
}
class SignInEvent extends AuthEvent {
  final String phone;
  final String code;
  SignInEvent({required this.phone, required this.code});

}
class RegisterEvent extends AuthEvent {
  final String phone;
  final String firstName;
  final String lastName;
  final int cityId;
  final File? avatar;
  RegisterEvent({required this.phone, required this.firstName, required this.lastName, required this.cityId, this.avatar});

}

