import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/config.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/modals/success_reusable_modal.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/history_orders/presentation/views/history_orders_view.dart';

import '../../../../locator.dart';
import 'left_bar_module_header.dart';
import 'left_bar_module_item.dart';

class LeftBar extends StatefulWidget {
  final Function() profileOnTap;
  final Function() cityOnTap;
  LeftBar({required this.cityOnTap, required this.profileOnTap});

  @override
  State<LeftBar> createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar> with TickerProviderStateMixin{
  bool reverse = false, reverse1 = false;

  Animation<Offset>?
    animation1, 
    animation2, 
    animation3, 
    animation4, 
    animation5, 
    animation6, 
    animation7, 
    animation8, 
    animation9, 
    animation10,
    animationForCat1,
    animationForCat2;
  AnimationController? 
    animationController1, 
    animationController2, 
    animationController3, 
    animationController4, 
    animationController5, 
    animationController6, 
    animationController7, 
    animationController8, 
    animationController9, 
    animationController10,
    animationControllerForCat1,
    animationControllerForCat2;

  @override
  void initState() {
  super.initState();
      animationController1  = new AnimationController(vsync: this, duration: Duration(milliseconds: 200));
      animationController2  = new AnimationController(vsync: this, duration: Duration(milliseconds: 250));
      animationController3  = new AnimationController(vsync: this, duration: Duration(milliseconds: 300));
      animationController4  = new AnimationController(vsync: this, duration: Duration(milliseconds: 350));
      animationController5  = new AnimationController(vsync: this, duration: Duration(milliseconds: 400));
      animationController6  = new AnimationController(vsync: this, duration: Duration(milliseconds: 450));
      animationController7  = new AnimationController(vsync: this, duration: Duration(milliseconds: 500));
      animationController8  = new AnimationController(vsync: this, duration: Duration(milliseconds: 550));
      animationController9  = new AnimationController(vsync: this, duration: Duration(milliseconds: 600));
      animationController10 = new AnimationController(vsync: this, duration: Duration(milliseconds: 650));
      animationControllerForCat1 = new AnimationController(vsync: this, duration: Duration(milliseconds: 300), animationBehavior: AnimationBehavior.preserve);
      animationControllerForCat2 = new AnimationController(vsync: this, duration: Duration(milliseconds: 350), animationBehavior: AnimationBehavior.preserve);

      animation1  = Tween<Offset>(begin: Offset(-0.5, 0), end: Offset(0, 0)).animate(animationController1!);
      animation2  = Tween<Offset>(begin: Offset(-0.5, 0), end: Offset(0, 0)).animate(animationController2!);
      animation3  = Tween<Offset>(begin: Offset(-0.5, 0), end: Offset(0, 0)).animate(animationController3!);
      animation4  = Tween<Offset>(begin: Offset(-0.5, 0), end: Offset(0, 0)).animate(animationController4!);
      animation5  = Tween<Offset>(begin: Offset(-0.5, 0), end: Offset(0, 0)).animate(animationController5!);
      animation6  = Tween<Offset>(begin: Offset(-0.5, 0), end: Offset(0, 0)).animate(animationController6!);
      animation7  = Tween<Offset>(begin: Offset(-0.5, 0), end: Offset(0, 0)).animate(animationController7!);
      animation8  = Tween<Offset>(begin: Offset(-0.5, 0), end: Offset(0, 0)).animate(animationController8!);
      animation9  = Tween<Offset>(begin: Offset(-0.5, 0), end: Offset(0, 0)).animate(animationController9!);
      animation10 = Tween<Offset>(begin: Offset(-0.5, 0), end: Offset(0, 0)).animate(animationController10!);
      animationForCat1 = Tween<Offset>(begin: Offset(0, -0.8), end: Offset(0, 0)).animate(animationControllerForCat1!);
      animationForCat2 = Tween<Offset>(begin: Offset(0, -0.8), end: Offset(0, 0)).animate(animationControllerForCat2!);


      animationController1!.forward();
      animationController2!.forward();
      animationController3!.forward();
      animationController4!.forward();
      animationController5!.forward();
      animationController6!.forward();
      animationController7!.forward();
      animationController8!.forward();
      animationController9!.forward();
      animationController10!.forward();
      animationControllerForCat1!.forward();
      animationControllerForCat2!.forward();
      
  }

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
              SizedBox(height: 10.h,),
              Row(
                children: [
                  isAuth && user!.avatar != null && user!.avatar != ''
                  ? GestureDetector(
                    onTap: widget.profileOnTap,
                    behavior: HitTestBehavior.translucent,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(Config.url.urlWithoutApi+user!.avatar)
                    ),
                  )
                  : GestureDetector(
                    onTap: widget.profileOnTap,
                    behavior: HitTestBehavior.translucent,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('assets/images/user.png')
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: widget.profileOnTap,
                        behavior: HitTestBehavior.translucent,
                        child: Text(
                          isAuth && user!.firstName != null
                          ? user!.firstName + ' ' + user!.lastName
                          : 'Ваше имя',
                          style: TextStyles.white_18_w700,),
                      ),
                      SizedBox(height: 5.h,),
                      GestureDetector(
                        onTap: widget.cityOnTap,
                        behavior: HitTestBehavior.translucent,
                        child: Text(
                          isAuth && user!.city != null
                          ? user!.city!.name
                          : 'Караганда', 
                          style: TextStyles.grey_16_w400,
                        ),
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
                    LeftBarModuleHeader(text: 'Навигация', animation: animationForCat1!,),
                    SizedBox(height: 20.h,),
                    LeftBarModuleItem(
                      animation: animation1!,
                      animationController: animationController1!,
                      icon: Icons.menu_book_outlined,
                      text: 'Меню',
                      onTap: (){
                      },
                    ),
                    LeftBarModuleItem(
                      animation: animation2!,
                      animationController: animationController2!,
                      icon: Icons.shopping_cart_outlined,
                      text: 'Корзина',
                      onTap: (){
                      },
                    ),
                    LeftBarModuleItem(
                      animation: animation3!,
                      animationController: animationController3!,
                      icon: Icons.info_outline_rounded,
                      text: 'О нас',
                      onTap: (){
                      },
                    ),
                    LeftBarModuleItem(
                      animation: animation4!,
                      animationController: animationController4!,
                      icon: Icons.view_list_rounded,
                      text: 'История заказов',
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HistoryOrdersView()));
                      },
                    ),
                    LeftBarModuleItem(
                      animation: animation5!,
                      animationController: animationController5!,
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
                    LeftBarModuleHeader(text: 'Контакты', animation: animationForCat2!),
                    SizedBox(height: 20.h,),
                    // LeftBarModuleItem(
                    //   iconText: 'VK',
                    //   text: 'Мы в VK',
                    //   onTap: (){
                    //   },
                    // ),
                    LeftBarModuleItem(
                      animation: animation6!,
                      animationController: animationController7!,
                      icon: Icons.photo_camera_outlined,
                      text: 'Мы в Instagram',
                      onTap: (){
                      },
                    ),
                    LeftBarModuleItem(
                      animation: animation8!,
                      animationController: animationController8!,
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
                      animation: animation9!,
                      animationController: animationController9!,
                      icon: Icons.qr_code_outlined,
                      text: 'QR code',
                      onTap: (){
                      },
                    ),
                    LeftBarModuleItem(
                      animation: animation10!,
                      animationController: animationController10!,
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