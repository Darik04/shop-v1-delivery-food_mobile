import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/toasts.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/category_card.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/product_card.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/loaders/loader_v1.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/home/presentation/widgets/head_carousel.dart';
import 'package:shopv1deliveryfood_mobile/features/product_details/presentation/views/product_details_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state){

          if(state is HomeErrorState){
            showAlertToast(state.message);
          }
        },
        
        builder: (context, state) {
          if(state is GotSuccessHomeProductsAndCategoriesState){
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h,),
                      HeadCarousel(urls: [
                        'https://elements-cover-images-0.imgix.net/b7baf8c8-ba17-4e35-9865-0fdeb552e7cf?auto=compress&crop=edges&fit=crop&fm=jpeg&h=630&w=1200&s=beffa2284fb0f3a624c1949831af34d7', 
                        'https://graphicsfamily.com/wp-content/uploads/edd/2020/11/Tasty-Food-Web-Banner-Design-scaled.jpg', 
                        'https://cdn.dribbble.com/users/5874456/screenshots/14313617/media/aad1c88ba7c6efb9d87b857a73d4c15c.jpg?compress=1&resize=400x300'
                      ],),
                      SizedBox(height: 15.h,),
                      Text(
                        'Категории',
                        style: TextStyles.black_18_w700,
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        height: 130.h,
                        child: ListView.builder(
                          itemCount: state.categories.length,
                          itemBuilder: (BuildContext context, int i){
                            return CategoryCard(
                              text: state.categories[i].title,
                              url: state.categories[i].icon,
                              func: (){

                              },
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      

                      SizedBox(height: 15.h,),
                      Text(
                        'Популярные товары',
                        style: TextStyles.black_18_w700,
                      ),
                      SizedBox(height: 10.h,),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.products.length,
                        itemBuilder: (BuildContext context, int i){
                          return ProductCard(
                            url: state.products[i].photo,
                            title: state.products[i].title,
                            description: state.products[i].description,
                            firstArgument: '25 мм',
                            secondArgument: '56 г',
                            price: state.products[i].price,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetailsView()));
                            },
                          );
                        },
                      ),



                      SizedBox(height: 10.h,),

                      Center(child: Text('Больше', style: TextStyles.green_18_w700),),
                      SizedBox(height: 25.h,),

                    ],
                  ),
                ),
              ),
            );
          }

          if(state is HomeLoadingState){
            return LoaderV1();
          }
          return Container();
        },
      )
      
    );
    
  }


}

