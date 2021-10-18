import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/features/address/data/models/city_model.dart';
import 'package:shopv1deliveryfood_mobile/features/address/presentation/views/choose_city.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/presentation/widgets/text_input.dart';

import '../../../../locator.dart';


class RegisterView extends StatefulWidget{
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  
  final formKey = GlobalKey<FormState>();
  
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController(text: sl<AuthConfig>().phone);
  TextEditingController _cityController = TextEditingController();

  String errorMessageFirstName = 'Введите ваше имя';
  String errorMessageLastName = 'Введите вашу фамилию';
  String errorMessageCity = 'Выберите город';

  CityModel? cityModel;

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: ColorStyles.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 10.h,),
              Container(
                  width: _width,
                  height: _height*0.26-50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 110.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 3)
                              ],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 2.w, color: ColorStyles.white)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image(
                                width: 110.w,
                                height: 100.h,
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/user.png'),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 1.w,
                            right: 1.w,
                            child: GestureDetector(
                              onTap: (){},
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                  border: Border.all(color: ColorStyles.white, width: 1.w),
                                  color: ColorStyles.primary
                                ),
                                width: 24,
                                height: 24,
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                  color: ColorStyles.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),



                SizedBox(height: 15.h,),
                TextInput(
                  hintText: 'Ваше имя *',
                  isEnable: true,
                  validator: (val){
                    return val!.length > 2 ? null : errorMessageFirstName;
                  },
                  controller: _firstNameController,
                  icon: Icons.person_outlined,
                  onTap: (){

                  },
                ),
                SizedBox(height: 12.h,),
                TextInput(
                  hintText: 'Ваше фамилия',
                  isEnable: true,
                  controller: _lastNameController,
                  icon: Icons.person_outlined,
                  onTap: (){

                  },
                ),
                SizedBox(height: 12.h,),
                TextInput(
                  hintText: 'Ваш город *',
                  isEnable: false,
                  validator: (val){
                    return cityModel != null ? null : errorMessageCity;
                  },
                  
                  controller: _cityController,
                  icon: Icons.location_on_outlined,
                  onTap: () async {
                    final city = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChooseCityView()));
                    if(city != null){
                      setState(() {
                        _cityController.text = city.name;
                        cityModel = city;
                      });
                    }
                  },
                ),
                SizedBox(height: 12.h,),
                TextInput(
                  hintText: 'Номер *',
                  isEnable: false,
                  controller: _phoneController,
                  icon: Icons.local_phone_outlined,
                  onTap: (){

                  },
                ),
                      
            ],
          ),
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 5,),
          PrimaryBtn(
            text: 'Подвердить', 
            onTap: (){
              if(formKey.currentState!.validate()){

              }
            }
          )
        ],
      ),
    );
  }
}