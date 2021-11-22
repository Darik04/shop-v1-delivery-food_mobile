part of 'change_number_bloc.dart';

class ChangeNumberEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class SendSMSForChangePhoneEvent extends ChangeNumberEvent{
  final bool isResend;
  final String newPhone;
  SendSMSForChangePhoneEvent({required this.newPhone, required this.isResend});
}
class UpdatePhoneEvent extends ChangeNumberEvent{
  final int code;
  UpdatePhoneEvent({required this.code});
}