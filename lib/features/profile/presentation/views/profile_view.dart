import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/helpers/address_helper.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/toasts.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/modals/dialog_loading_modal.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/entities/address_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/entities/city_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/address/presentation/views/address_delivery.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/presentation/views/change_number_enter_code_view.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/presentation/widgets/text_input.dart';

import '../../../../locator.dart';
import 'change_number_enter_phone_view.dart';


class ProfileView extends StatefulWidget {

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  UserEntity? _userEntity;

  File? avatar;

  CityEntity? cityEntity;

  @override
  void initState() {
    super.initState();
    UserEntity userEntity = sl<AuthConfig>().userEntity!;
    firstNameController.text = userEntity.firstName;
    lastNameController.text = userEntity.lastName;
    numberController.text = userEntity.phone;
    addressController.text = getCheckedAddress(userEntity);
    _userEntity = userEntity;
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль', style: Theme.of(context).appBarTheme.titleTextStyle,),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
              context.read<AuthBloc>().add(LogoutEvent());
            },
            child: const Icon(
              Icons.exit_to_app_outlined,
              size: 30,
              color: ColorStyles.red_accent,
            ),
          ),
          SizedBox(width: 10.w,)
        ],
      ),
      backgroundColor: ColorStyles.back_grey,
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state){
          if(state is ChangedSuccessState){
            Navigator.pop(context);
            Navigator.pop(context);
            context.read<AuthBloc>().add(CheckUserLoggedEvent());
          }
          if(state is ProfileErrorState){
            Navigator.pop(context);
            showAlertToast(state.message);
          }
        },
        builder: (context, state){
          return SingleChildScrollView(
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
                            width: 110.h,
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
                                width: 110.h,
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
                        controller: lastNameController,
                        icon: Icons.person_outlined,
                        onTap: (){

                        },
                      ),
                      SizedBox(height: 12.h,),
                      TextInput(
                        hintText: 'Ваш адрес',
                        isEnable: false,
                        controller: addressController,
                        icon: Icons.location_on_outlined,
                        onTap: () async {
                          AddressEntity? _addressEntity = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DeliveryAddressView()));
                          if(_addressEntity != null){
                            setState(() {
                              cityEntity = _addressEntity.city;
                              addressController.text = getCheckedAddressFromAddress(_addressEntity);
                            });
                          }
                        },
                      ),
                      SizedBox(height: 12.h,),
                      TextInput(
                        hintText: 'Номер',
                        isEnable: false,
                        controller: numberController,
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
          );
        },
      ),
      

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 5.h,),
          PrimaryBtn(
            text: 'Сохранить',
            onTap: (){
              Dialogs.showLoadingDialog(context);
              context.read<ProfileBloc>().add(UpdateUserInfoEvent(
                firstName: firstNameController.text.trim(),
                lastName: lastNameController.text.trim(),
                avatar: avatar,
                cityId: cityEntity != null ? cityEntity!.id : _userEntity!.city!.id,
                
              ));
            },
          ),
        ],
      ),
    );

    
  }
}
