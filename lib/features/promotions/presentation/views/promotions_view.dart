import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/promotion_card.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/loaders/loader_v1.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/presentation/bloc/promotions/promotions_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/presentation/views/promotion_details_view.dart';


class PromotionsView extends StatelessWidget {
  const PromotionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PromotionsBloc, PromotionsState>(
        listener: (context, state){},
        builder: (context, state){
          if(state is PromotionsInitialState || state is PromotionsLoadingState){
            return LoaderV1();
          }
          if(state is GotSuccessPromotionsState){
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.promotions.length,
                  itemBuilder: (BuildContext context, int i){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PromotionDetailsView(promotion: state.promotions[i])));
                      },
                      child: PromotionCard(promotion: state.promotions[i],)
                    );
                  },
                )
              ),
            );
          }
          return Container();
        },
      )
      
    );
  }
}