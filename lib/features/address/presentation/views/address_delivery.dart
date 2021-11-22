import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/maps/maps_types.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/entities/address_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/entities/city_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/address/presentation/views/choose_city.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/user_entity.dart';

import '../../../../locator.dart';

class DeliveryAddressView extends StatefulWidget {

  @override
  State<DeliveryAddressView> createState() => _DeliveryAddressViewState();
}

class _DeliveryAddressViewState extends State<DeliveryAddressView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController entranceController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  double? lat;
  double? long;

  CityEntity? cityEntity;

  String errorCity = 'Выберите город';
  String errorStreet = 'Введите вашу улицу';
  String errorHomeNumber = 'Дом';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(sl<AuthConfig>().authenticatedOption);
    if(sl<AuthConfig>().authenticatedOption == AuthenticatedOption.authenticated){
      UserEntity userEntity = sl<AuthConfig>().userEntity!;
      cityEntity = userEntity.city;
      cityController.text = userEntity.city != null ? userEntity.city!.name : '';
      streetController.text = userEntity.street ?? '';
      homeNumberController.text = userEntity.homeNumber ?? '';
      entranceController.text = userEntity.entrance ?? '';
      apartmentController.text = userEntity.apartment ?? '';
      lat = userEntity.lat;
      long = userEntity.long;
    }
  }


  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Адрес доставки', style: Theme.of(context).appBarTheme.titleTextStyle,)
      ),
      body: Column(
        children: [
          Container(
            width: _width,
            height: 230.h,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(51.5, -0.09),
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: MapTypes.standard.url,
                  subdomains: ['a', 'b', 'c']
                ),
                MarkerLayerOptions(
                  markers: [
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: _width,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            color: ColorStyles.green_accent,
            alignment: Alignment.center,
            child: Text('Потяните карту, чтобы выбрать адрес', style: TextStyles.white_16_w400,),
          ),

          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    onTap: () async {
                      CityEntity? _cityEntity = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChooseCityView()));
                      if(_cityEntity != null){
                        setState(() {
                          cityEntity = _cityEntity;
                          cityController.text = _cityEntity.name;
                        });
                      }
                    },
                    controller: cityController,
                    decoration: InputDecoration(
                      labelText: 'Город',
                      labelStyle: TextStyles.grey_14_w400,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w))
                    ),
                    validator: (val){
                      return cityController.text != null && cityController.text != '' ? null : errorCity;
                    },
                    readOnly: true,

                    style: TextStyles.black_16_w700,
                  ),
                  SizedBox(height: 5.h,),
                  TextFormField(
                    controller: streetController,
                    decoration: InputDecoration(
                      labelText: 'Улица',
                      labelStyle: TextStyles.grey_14_w400,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w)),
                      counter: Offstage(),
                    ),
                    validator: (val){
                      return val!.length > 1 && val != null ? null : errorStreet;
                    },
                    maxLength: 60,
                    enabled: true,
                    
                    style: TextStyles.black_14_w400,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: homeNumberController,
                          decoration: InputDecoration(
                            labelText: 'Дом',
                            labelStyle: TextStyles.grey_14_w400,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w)),
                            counter: Offstage(),

                          ),
                          validator: (val){
                            return val!.length > 1 && val != null ? null : errorHomeNumber;
                          },
                          enabled: true,
                          maxLength: 20,
                          style: TextStyles.black_14_w400,
                        ),
                      ),
                      SizedBox(width: 30.w),
                      Expanded(
                        child: TextFormField(
                          controller: entranceController,
                          decoration: InputDecoration(
                            labelText: 'Подъезд',
                            labelStyle: TextStyles.grey_14_w400,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w)),
                            counter: Offstage(),
                          ),
                          maxLength: 20,
                          enabled: true,
                          
                          style: TextStyles.black_14_w400,
                        ),
                      ),
                      SizedBox(width: 30.w),
                      Expanded(
                        child: TextFormField(
                          controller: apartmentController,
                          decoration: InputDecoration(
                            labelText: 'Квартира',
                            labelStyle: TextStyles.grey_14_w400,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorStyles.main_grey, width: 1.w)),
                            counter: Offstage(),
                          ),
                          enabled: true,
                          maxLength: 20,
                          
                          style: TextStyles.black_14_w400,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 30.h,),
          PrimaryBtn(
            text: 'Применить',
            onTap: (){
              if(formKey.currentState!.validate()){
                Navigator.pop(context,
                  AddressEntity(
                    city: cityEntity, 
                    street: streetController.text.trim(), 
                    homeNumber: homeNumberController.text.trim(), 
                    entrance: entranceController.text.trim(), 
                    apartment: apartmentController.text.trim()
                  )
                );
              }
            }
          )
        ],
      ),
    );
  }
}