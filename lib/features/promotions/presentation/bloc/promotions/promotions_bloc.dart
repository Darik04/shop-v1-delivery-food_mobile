import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopv1deliveryfood_mobile/core/error/failures.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/entities/promotion_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/domain/usecases/get_promotions.dart';
part 'promotions_event.dart';
part 'promotions_state.dart';

class PromotionsBloc extends Bloc<PromotionsEvent, PromotionsState> {
  final GetPromotionsWithPagination getPromotionsWithPagination; 
  
  PromotionsBloc(this.getPromotionsWithPagination) : super(PromotionsInitialState());

  @override
  Stream<PromotionsState> mapEventToState(PromotionsEvent event) async*{
    if(event is GetPromotionsWithPaginationEvent){
      yield PromotionsLoadingState();
      var promos = await getPromotionsWithPagination(GetPromotionsWithPaginationParams(page: 1));
      //Folding promos
      yield promos.fold(
        (failure){
          print('ERROR: ${failure}');
          if(failure is ConnectionFailure){
            return InternetConnectionFailureState();
          }
          return PromotionsErrorState(message: 'Не смогли загрузить акции');
        },
        (promos){
          return GotSuccessPromotionsState(promotions: promos);
        }
      );
    }


    
  }

}
