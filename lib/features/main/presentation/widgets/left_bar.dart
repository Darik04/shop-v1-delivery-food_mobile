import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/config.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/modals/success_reusable_modal.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/user_entity.dart';

import '../../../../locator.dart';
import 'left_bar_module_header.dart';
import 'left_bar_module_item.dart';

class LeftBar extends StatelessWidget {

  UserEntity? user = sl<AuthConfig>().userEntity;
  bool isAuth = sl<AuthConfig>().authenticatedOption == AuthenticatedOption.authenticated;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorStyles.black
      ),
      width: MediaQuery.of(context).size.width*0.82,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
          child: Column(
            children: [
              Row(
                children: [
                  isAuth && user!.avatar != null && user!.avatar != ''
                  ? CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(Config.url.urlWithoutApi+user!.avatar)
                  )
                  : CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/images/user.png')
                  ),
                  SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAuth && user!.firstName != null
                        ? user!.firstName + ' ' + user!.lastName
                        : 'Ваше имя',
                        style: TextStyles.white_18_w700,),
                      SizedBox(height: 5.h,),
                      Text(
                        isAuth && user!.city != null
                        ? user!.city!.name
                        : 'Караганда', 
                        style: TextStyles.grey_16_w400,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 60.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeftBarModuleHeader(text: 'Навигация'),
                    SizedBox(height: 20.h,),
                    LeftBarModuleItem(
                      icon: Icons.menu_book_outlined,
                      text: 'Меню',
                      onTap: (){
                      },
                    ),
                    LeftBarModuleItem(
                      icon: Icons.shopping_cart_outlined,
                      text: 'Корзина',
                      onTap: (){
                      },
                    ),
                    LeftBarModuleItem(
                      icon: Icons.info_outline_rounded,
                      text: 'О нас',
                      onTap: (){
                      },
                    ),
                    LeftBarModuleItem(
                      icon: Icons.view_list_rounded,
                      text: 'История заказов',
                      onTap: (){
                      },
                    ),
                    LeftBarModuleItem(
                      icon: Icons.chrome_reader_mode_outlined,
                      text: 'Написать feedback',
                      onTap: (){
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h,),
              Container(
                color: ColorStyles.main_grey,
                width: MediaQuery.of(context).size.width*0.6,
                height: 1.h,
              ),
              SizedBox(height: 40.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeftBarModuleHeader(text: 'Контакты'),
                    SizedBox(height: 20.h,),
                    // LeftBarModuleItem(
                    //   iconText: 'VK',
                    //   text: 'Мы в VK',
                    //   onTap: (){
                    //   },
                    // ),
                    LeftBarModuleItem(
                      icon: Icons.photo_camera_outlined,
                      text: 'Мы в Instagram',
                      onTap: (){
                      },
                    ),
                    LeftBarModuleItem(
                      icon: Icons.facebook_outlined,
                      text: 'Мы в Facebook',
                      onTap: (){
                        SuccessReusableModal(
                          context: context,
                          title: 'Номер успешно сменен',
                          subTitle: 'Теперь у вас новый номер',
                          btnTitle: 'Хорошо',
                          onTap: (){
                            Navigator.pop(context);
                          }
                        ).showMyDialog();
                      },
                    ),
                    LeftBarModuleItem(
                      icon: Icons.qr_code_outlined,
                      text: 'QR code',
                      onTap: (){
                      },
                    ),
                    LeftBarModuleItem(
                      icon: Icons.web,
                      text: 'Web сайт',
                      onTap: (){
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}