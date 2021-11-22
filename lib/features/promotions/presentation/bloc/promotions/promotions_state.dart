part of 'promotions_bloc.dart';

class PromotionsState extends Equatable {
  const PromotionsState();
  @override
  List<Object> get props => [];
}

class PromotionsInitialState extends PromotionsState {}
class PromotionsLoadingState extends PromotionsState {}
class PromotionsErrorState extends PromotionsState {
  final String message;
  PromotionsErrorState({required this.message});
}
class InternetConnectionFailureState extends PromotionsState {}

class GotSuccessPromotionsState extends PromotionsState{
  final List<PromotionEntity> promotions;
  GotSuccessPromotionsState({required this.promotions});
}
