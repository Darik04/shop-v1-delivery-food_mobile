import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/toasts.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/loaders/loader_v1.dart';
import 'package:shopv1deliveryfood_mobile/features/address/presentation/bloc/city/city_bloc.dart';

class ChooseCityView extends StatefulWidget {

  @override
  State<ChooseCityView> createState() => _ChooseCityViewState();
}

class _ChooseCityViewState extends State<ChooseCityView> {
  
  @override
  void initState() { 
    super.initState();
    context.read<CityBloc>().add(GetAllCitiesEvent());
  }
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Выборка города', style: Theme.of(context).appBarTheme.titleTextStyle,)
      ),
      body: BlocConsumer<CityBloc, CityState>(
        listener: (context, state){
          if(state is ErrorState){
            showAlertToast(state.message);
          }
        },
        
        builder: (context, state) {
          if(state is InitialState || state is LoadingState){
            return LoaderV1();
          }
          if(state is SuccessGotAllCitiesState){
            print('cities got: ${state.cities.first.name}');
            return SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.cities == null ? 0 : state.cities.length,
                itemBuilder: (BuildContext context, int i){
                  return Column(
                    children: [
                      i == 0 || state.cities[i].name[0] != state.cities[i-1].name[0]
                      ? Container(
                        color: ColorStyles.back_grey,
                        width: _width,
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(state.cities[i].name[0], style: TextStyles.title_app_bar),
                      ) : SizedBox.shrink(),
                      
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          Navigator.pop(context, state.cities[i]);
                        },
                        child: Container(
                          width: _width,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          margin: EdgeInsets.symmetric(vertical: 5.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: ColorStyles.primary,
                                size: 20,
                              ),
                              SizedBox(width: 8.w,),
                              Text(state.cities[i].name, style: TextStyles.black_18_w400,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            );
          }

          return Container();
        },
 
      ),
    );
  }
}