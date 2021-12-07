import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/locator.dart';

import 'features/address/presentation/bloc/city/city_bloc.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/views/splash_view.dart';
import 'features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'features/favorites/presentation/bloc/favorite/favorite_bloc.dart';
import 'features/home/presentation/bloc/home/home_bloc.dart';
import 'features/list_products/presentation/bloc/list_products/list_products_bloc.dart';
import 'features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'features/profile/presentation/bloc/change_number/change_number_bloc.dart';
import 'features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'features/promotions/presentation/bloc/promotions/promotions_bloc.dart';


void main() {
  setupInjections();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 893),

      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<AuthBloc>()),
          BlocProvider(create: (_) => sl<CityBloc>()),
          BlocProvider(create: (_) => sl<HomeBloc>()),
          BlocProvider(create: (_) => sl<PromotionsBloc>()),
          BlocProvider(create: (_) => sl<ProfileBloc>()),
          BlocProvider(create: (_) => sl<ChangeNumberBloc>()),
          BlocProvider(create: (_) => sl<ListProductsBloc>()),
          BlocProvider(create: (_) => sl<FavoriteBloc>()),
          BlocProvider(create: (_) => sl<CartBloc>()),
          BlocProvider(create: (_) => sl<MainScreenBloc>()),
        
        ], 
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop v1',
            theme: ThemeData(
            primaryColor: ColorStyles.primary,
            primarySwatch: Colors.orange,
            appBarTheme: AppBarTheme(
              backgroundColor: ColorStyles.white,
              centerTitle: true,
              titleTextStyle: TextStyles.title_app_bar,
              elevation: 3.0,
              toolbarHeight: 56,
              iconTheme: IconThemeData(
                color: ColorStyles.black,
              )
              
            )
          ),
          home: SplashView(),
        ),
      ),


      // builder: () => MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   title: 'Shop v1',
      //   theme: ThemeData(
      //     primaryColor: ColorStyles.primary,
      //     primarySwatch: Colors.orange,
      //     appBarTheme: AppBarTheme(
      //       backgroundColor: ColorStyles.white,
      //       centerTitle: true,
      //       titleTextStyle: TextStyles.title_app_bar,
      //       elevation: 3.0,
      //       toolbarHeight: 56,
      //       iconTheme: IconThemeData(
      //         color: ColorStyles.black
      //       )
            
      //     )
      //   ),
      //   home: MainView(),
      // ),
      
    );
  }
}
