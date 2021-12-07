import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/modals/success_reusable_modal.dart';
import 'package:shopv1deliveryfood_mobile/features/additions/presentation/views/loading_view.dart';
import 'package:shopv1deliveryfood_mobile/features/additions/presentation/views/loading_with_header_view.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/usecases/clear_cart.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/presentation/views/cart_view.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/presentation/views/favorites_view.dart';
import 'package:shopv1deliveryfood_mobile/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/home/presentation/views/home_view.dart';
import 'package:shopv1deliveryfood_mobile/features/home/presentation/views/home_view_v2.dart';
import 'package:shopv1deliveryfood_mobile/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/main/presentation/widgets/left_bar.dart';
import 'package:shopv1deliveryfood_mobile/features/main/presentation/widgets/left_bar_module_header.dart';
import 'package:shopv1deliveryfood_mobile/features/main/presentation/widgets/left_bar_module_item.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/presentation/views/profile_view.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/presentation/bloc/promotions/promotions_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/presentation/views/promotions_view.dart';

import '../../../../locator.dart';


class MainView extends StatefulWidget {
  final int? view;
  MainView({this.view});
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  final List<Widget> _mainViews = [
    HomeView(),
    PromotionsView(),
    FavoritesView(),
    CartView(),
    // Profile will be navigate to view(screen)
  ];
  int _currentView = 0;
  double _iconSize = 26.sp;
  double _heightBtns = 46.h;


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(GetHomeProductsWithPaginationEvent());
    context.read<PromotionsBloc>().add(GetPromotionsWithPaginationEvent());
    if(sl<AuthConfig>().authenticatedOption == AuthenticatedOption.authenticated){
      context.read<FavoriteBloc>().add(GetFavoriteProductsEvent());
      context.read<CartBloc>().add(GetCartProductsEvent());
    }


    if(widget.view != null){
      _currentView = widget.view!;
    }

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainScreenBloc, MainScreenState>(
      listener: (context, state){
        if(state is MainScreenChangedState){
          setState(() {
            _currentView = state.currentView;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: LeftBar(
            profileOnTap: (){
              if(sl<AuthConfig>().authenticatedOption == AuthenticatedOption.authenticated)
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfileView()));
              else
                context.read<AuthBloc>().add(OpenAuthFormEvent());
            },
            cityOnTap: (){

            },
          ),
          appBar: AppBar(
            title: Text(_currentView == 1
            ? 'Акции'
            : _currentView == 2
            ? 'Избранное'
            : _currentView == 3
            ? 'Корзина'
            : 'Logo', style: TextStyles.title_app_bar,),
            leading: Row(
              children: [
                SizedBox(width: 15.w,),
                GestureDetector(
                  onTap: (){
                    //Here will be code
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Icon(
                    Icons.menu_outlined,
                    size: 40.sp,
                  ),
                ),
              ],
            ),
            actions: _currentView == 3 && context.read<CartBloc>().products.isNotEmpty
            ? [
              GestureDetector(
                onTap: (){
                  context.read<CartBloc>().add(ClearCartEvent());
                },
                child: const Icon(
                  Icons.delete_outline,
                  size: 30,
                  color: ColorStyles.red_accent,
                ),
              ),
              SizedBox(width: 10.w,)
            ] : [],
          ),
          body: _mainViews.elementAt(_currentView),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _currentView,
            onTap: (int index){
              
              if(index == 4){
                if(sl<AuthConfig>().authenticatedOption == AuthenticatedOption.authenticated)
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfileView()));
                else
                  context.read<AuthBloc>().add(OpenAuthFormEvent());
                
              } else if(index == 2 && sl<AuthConfig>().authenticatedOption == AuthenticatedOption.unauthenticated){
                context.read<AuthBloc>().add(OpenAuthFormEvent());
              } else{
                context.read<MainScreenBloc>().add(ChangeViewEvent(view: index));

              }
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Container(
                  height: _heightBtns,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.menu_book_outlined,
                        color: _currentView == 0 ? ColorStyles.black : ColorStyles.main_grey,
                        size: _iconSize,
                      ),
                      Text('Меню', style: _currentView == 0 ? TextStyles.black_12_w700 : TextStyles.black_12_w700.copyWith(color: ColorStyles.main_grey))
                    ],
                  ),
                ),
                label: 'Меню'),
              BottomNavigationBarItem(
                icon: Container(
                  height: _heightBtns,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.list_alt_sharp,
                        color: _currentView == 1 ? ColorStyles.black : ColorStyles.main_grey,
                        size: _iconSize,
                      ),
                      Text('Акции', style: _currentView == 1 ? TextStyles.black_12_w700 : TextStyles.black_12_w700.copyWith(color: ColorStyles.main_grey))
                    ],
                  ),
                ),
                label: 'Меню'),
              BottomNavigationBarItem(
                icon: Container(
                  height: _heightBtns,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.bookmark_border_outlined,
                        color: _currentView == 2 ? ColorStyles.black : ColorStyles.main_grey,
                        size: _iconSize + 1.sp,
                      ),
                      Text('Избранное', style: _currentView == 2 ? TextStyles.black_12_w700 : TextStyles.black_12_w700.copyWith(color: ColorStyles.main_grey))
                    ],
                  ),
                ),
                label: 'Избранное'),
              BottomNavigationBarItem(
                icon: Container(
                  height: _heightBtns,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: _currentView == 3 ? ColorStyles.black : ColorStyles.main_grey,
                        size: _iconSize,
                      ),
                      Text('Корзина', style: _currentView == 3 ? TextStyles.black_12_w700 : TextStyles.black_12_w700.copyWith(color: ColorStyles.main_grey))
                    ],
                  ),
                ),
                label: 'Корзина'),
              BottomNavigationBarItem(
                icon: Container(
                  height: _heightBtns,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: _currentView == 4 ? ColorStyles.black : ColorStyles.main_grey,
                        size: _iconSize,
                      ),
                      Text('Профиль', style: _currentView == 4 ? TextStyles.black_12_w700 : TextStyles.black_12_w700.copyWith(color: ColorStyles.main_grey))
                    ],
                  ),
                ),
                label: 'Профиль'),
            ],
          ),
        );
      }
    );
  }
}