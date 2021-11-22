part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}
class ProfileLoadingState extends ProfileState {}
class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState({required this.message});
}
class InternetConnectionFailureState extends ProfileState {}

class ChangedSuccessState extends ProfileState{}
