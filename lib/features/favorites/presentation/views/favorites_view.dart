import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/product_card.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/promotion_card.dart';
import 'package:shopv1deliveryfood_mobile/features/product_details/presentation/views/product_details_view.dart';


class FavoritesView extends StatelessWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 15.h,),

              // ProductCard(
              //   url: '',
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetailsView()));
              //   },
              // ),
              // ProductCard(
              //   url: '',
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetailsView()));
              //   },
              // ),
              // ProductCard(
              //   url: '',
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetailsView()));
              //   },
              // ),
              // ProductCard(
              //   url: '',
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetailsView()));
              //   },
              // ),
              SizedBox(height: 10.h,),
              
            ],
          ),
        ),
      )
    );
  }
}