import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/src/provider.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/category_card.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/product_card.dart';
import 'package:shopv1deliveryfood_mobile/features/address/presentation/views/address_delivery.dart';
import 'package:shopv1deliveryfood_mobile/features/address/presentation/views/choose_city.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/views/enter_code_view.dart';
import 'package:shopv1deliveryfood_mobile/features/history_orders/presentation/views/history_orders_view.dart';
import 'package:shopv1deliveryfood_mobile/features/home/presentation/widgets/head_carousel.dart';
import 'package:shopv1deliveryfood_mobile/features/product_details/presentation/views/product_details_view.dart';
import 'package:shopv1deliveryfood_mobile/features/products_by_category/presentation/views/products_by_category_views.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  var maskFormatter = new MaskTextInputFormatter(mask: '+7 (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });
  final formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h,),
                HeadCarousel(urls: ['', '', ''],),
                SizedBox(height: 15.h,),
                Text(
                  'Категории',
                  style: TextStyles.black_18_w700,
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 130.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(width: 1.w,),
                      GestureDetector(
                        onTap: (){
                          _showSourceTypeModal(context: context);
                        },
                        child: CategoryCard(
                          text: 'Бургеры',
                          url: ''
                        ),
                      ),
                      CategoryCard(
                        text: 'Пиццы',
                        url: ''
                      ),
                      CategoryCard(
                        text: 'Суши',
                        url: ''
                      ),
                      CategoryCard(
                        text: 'Супы',
                        url: ''
                      )
                    ],
                  ),
                ),
                

                SizedBox(height: 15.h,),
                Text(
                  'Популярные товары',
                  style: TextStyles.black_18_w700,
                ),
                SizedBox(height: 10.h,),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ProductCard(
                      url: '',
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetailsView()));
                      },
                    ),
                    ProductCard(
                      url: '',
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetailsView()));
                      },
                    ),
                    ProductCard(
                      url: '',
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetailsView()));
                      },
                    ),
                  ],
                ),



                SizedBox(height: 10.h,),

              ],
            ),
          ),
        ),
      )
    );
    
  }

  _showSourceTypeModal({
    required BuildContext context,
  }) {


    Widget modalSheet = Container(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height*0.66,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 100.h),
              
              Text('Введите ваш номер телефона', style: TextStyles.black_18_w700,),
              SizedBox(height: 14.h),
              Form(
                key: formKey,
                child: TextFormField(
                  validator: (val){
                    return val!.length > 17 ? null : 'Введите номер телефона';
                  },
                  inputFormatters: [maskFormatter],
                  controller: _phoneController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Номер',
                    isDense: true,
             
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: ColorStyles.main_grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              PrimaryBtn(
                text: 'Авторизоваться', 
                onTap: (){
                  if(formKey.currentState!.validate()){
                    String phone = _phoneController.text
                            .replaceAll(RegExp("\\("), "")
                            .replaceAll(RegExp("\\)"), "")
                            .replaceAll(RegExp("-"), "")
                            .replaceAll(RegExp(r"\s+\b|\b\s"), "");
                    print('Formatted phone is: $phone');
                    context.read<AuthBloc>().add(SendSMSEvent(phone: phone));
                    Navigator.pop(context);
                  }
                }
              )
            ],
          ),
        )
      ),
    );


  



    // show the dialog
    showMaterialModalBottomSheet(
      elevation: 6,
      duration: Duration(milliseconds: 300),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )
      ),
      builder: (BuildContext context) {
        return modalSheet;
      },
    );
  }
}

