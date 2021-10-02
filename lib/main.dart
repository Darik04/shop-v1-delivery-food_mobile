import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/locator.dart';

import 'features/address/presentation/bloc/city_bloc.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/views/splash_view.dart';


void main() async {
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
                color: ColorStyles.black
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
