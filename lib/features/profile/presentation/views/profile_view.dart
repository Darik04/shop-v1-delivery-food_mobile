import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/presentation/views/change_number_enter_code_view.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/presentation/widgets/text_input.dart';

import 'change_number_enter_phone_view.dart';


class ProfileView extends StatelessWidget {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль', style: Theme.of(context).appBarTheme.titleTextStyle,),
      ),
      backgroundColor: ColorStyles.back_grey,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
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
            Container(
              width: _width,
              height: _height*0.74-50,
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 15.w),
              decoration: BoxDecoration(
                color: ColorStyles.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 3)
                ]
              ),
              child: Column(
                children: [
                  TextInput(
                    hintText: 'Ваше имя',
                    isEnable: true,
                    controller: firstNameController,
                    icon: Icons.person_outlined,
                    onTap: (){

                    },
                  ),
                  SizedBox(height: 12.h,),
                  TextInput(
                    hintText: 'Ваше фамилия',
                    isEnable: true,
                    controller: firstNameController,
                    icon: Icons.person_outlined,
                    onTap: (){

                    },
                  ),
                  SizedBox(height: 12.h,),
                  TextInput(
                    hintText: 'Ваш адрес',
                    isEnable: false,
                    controller: firstNameController,
                    icon: Icons.location_on_outlined,
                    onTap: (){

                    },
                  ),
                  SizedBox(height: 12.h,),
                  TextInput(
                    hintText: 'Номер',
                    isEnable: false,
                    controller: firstNameController,
                    icon: Icons.local_phone_outlined,
                    onTap: (){  
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChangeNumberEnterPhoneView()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 5.h,),
          PrimaryBtn(
            text: 'Сохранить',
            onTap: (){},
          ),
        ],
      ),
    );

    
  }
}
