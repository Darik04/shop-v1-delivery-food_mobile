part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class UpdateUserInfoEvent extends ProfileEvent{
  final String firstName;
  final String lastName;
  final int cityId;
  final File? avatar;
  UpdateUserInfoEvent({required this.firstName, required this.lastName, required this.cityId, this.avatar});
}
