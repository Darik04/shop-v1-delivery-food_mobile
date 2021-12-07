import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/helpers/cart_helper.dart';
import 'package:shopv1deliveryfood_mobile/core/utils/toasts.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/cards/product_card.dart';
import 'package:shopv1deliveryfood_mobile/core/widgets/loaders/loader_v1.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/enums/sort_enum.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/presentation/bloc/list_products/list_products_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/product_details/presentation/views/product_details_view.dart';

import '../../../../locator.dart';

class ListProductsView extends StatefulWidget {
  final int? categoryId;
  final String? categoryName;
  ListProductsView({this.categoryId, this.categoryName});

  @override
  State<ListProductsView> createState() => _ListProductsViewState();
}
class SortItem{
  final SortByEnum sortByEnum;
  final String title;

  SortItem({required this.sortByEnum, required this.title});
}
class _ListProductsViewState extends State<ListProductsView> {

  final List<SortItem> sorts = [
    SortItem(sortByEnum: SortByEnum.createdAt, title: 'Сначала новые'),
    SortItem(sortByEnum: SortByEnum.priceDown, title: 'Сначала дороже'),
    SortItem(sortByEnum: SortByEnum.priceUp, title: 'Сначала дешевле'),
  ];
  SortItem? selectedSortItem;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    selectedSortItem = sorts[0];
    context.read<ListProductsBloc>().pagination = null;
    context.read<ListProductsBloc>().products.clear();
    context.read<ListProductsBloc>().page = 0;
    context.read<ListProductsBloc>().add(GetProductsEvent(categoryId: widget.categoryId, sortByEnum: selectedSortItem!.sortByEnum));
    
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
        context.read<ListProductsBloc>().add(GetProductsEvent(categoryId: widget.categoryId, sortByEnum: selectedSortItem!.sortByEnum));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    ListProductsBloc listProductsBloc = context.read<ListProductsBloc>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName != null ? widget.categoryName! : 'Все товары', style: Theme.of(context).appBarTheme.titleTextStyle,),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ),
      body: BlocConsumer<ListProductsBloc, ListProductsState>(
        listener: (context, state){
          if(state is ListProductsErrorState){
            showAlertToast(state.message);
          }
        },
        builder: (context, state) {
          if(state is ListProductsInitialState || state is ListProductsLoadingState){
            return LoaderV1();
          }
          if(state is ProductsGotSuccessState || state is ListProductsBlankState){
            if(listProductsBloc.products.isNotEmpty)
              // ignore: curly_braces_in_flow_control_structures
              return SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 3.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${listProductsBloc.pagination!.count} товара', style: TextStyles.grey_14_w400,),
                            DropdownButton<SortItem>(
                              icon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                                size: 30,
                                color: ColorStyles.grey888
                              ),
                              borderRadius: BorderRadius.circular(10),
                              underline: SizedBox.shrink(),
                              hint: Text('Сортировать по', style: TextStyles.grey_14_w400),
                              items: sorts.map((SortItem sortItem) {
                                return DropdownMenuItem<SortItem>(
                                  value: sortItem,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(sortItem.title, style: TextStyles.black_14_w400,),
                                      SizedBox(width: 4.0),
                                      selectedSortItem == sortItem
                                      ?
                                      SvgPicture.string(
                                        '<svg width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7.57287 1.75781C4.35945 1.75781 1.75391 4.38145 1.75391 7.61719C1.75391 10.8529 4.35945 13.4766 7.57287 13.4766C10.7863 13.4766 13.3918 10.8529 13.3918 7.61719C13.3918 4.38145 10.7863 1.75781 7.57287 1.75781ZM10.0862 5.70374L7.35076 9.52279C7.31253 9.57653 7.26213 9.62031 7.20374 9.65051C7.14535 9.68072 7.08065 9.69647 7.015 9.69647C6.94936 9.69647 6.88466 9.68072 6.82627 9.65051C6.76788 9.62031 6.71748 9.57653 6.67925 9.52279L5.05955 7.26275C5.01019 7.19343 5.05955 7.09665 5.14397 7.09665H5.75315C5.88563 7.09665 6.01162 7.16073 6.08956 7.2706L7.01436 8.5628L9.05619 5.71158C9.13412 5.60303 9.25881 5.53763 9.3926 5.53763H10.0018C10.0862 5.53763 10.1356 5.63442 10.0862 5.70374Z" fill="#27AE60"/></svg>',
                                        allowDrawingOutsideViewBox: true,
                                        fit: BoxFit.fill,
                                      )
                                      :
                                      Container()
                                    ],
                                  ),
                                );
                              }).toList(),

                              onChanged: (newValue) {
                                setState(() {
                                  selectedSortItem = newValue;
                                  listProductsBloc.products.clear();
                                  listProductsBloc.page = 0;
                                  listProductsBloc.pagination = null;
                                });
                                context.read<ListProductsBloc>().add(GetProductsEvent(categoryId: widget.categoryId, sortByEnum: selectedSortItem!.sortByEnum));
                              },
                              value: selectedSortItem,
                            )
                          
                          ],
                        ),
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: listProductsBloc.products.length,
                        itemBuilder: (BuildContext context, int i){
                          return ProductCard(
                            productEntity: listProductsBloc.products[i],
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetailsView(productId: listProductsBloc.products[i].id,)));
                            },
                            addToCartTap: (){
                              
                              setState(() {
                                addToCart(context: context, productEntity: listProductsBloc.products[i]);
                              });
                            },
                            addToFavoritesTap: (){
                              if(sl<AuthConfig>().authenticatedOption == AuthenticatedOption.authenticated){
                                setState(() {
                                  if(listProductsBloc.products[i].countInFavorite == 0){
                                    listProductsBloc.products[i].countInFavorite = 1;
                                    context.read<FavoriteBloc>().add(AddToFavoriteEvent(product: listProductsBloc.products[i]));
                                  }else{
                                    listProductsBloc.products[i].countInFavorite = 0;
                                    context.read<FavoriteBloc>().add(DeleteFromFavoriteEvent(productId: listProductsBloc.products[i].id));
                                  }
                                });
                              }else{
                                context.read<AuthBloc>().add(OpenAuthFormEvent());
                              }
                            },
                            removeFromCartTap: (){
                              setState(() {
                                deleteFromCart(context: context, productEntity: listProductsBloc.products[i]);
                              });
                            },
                          );
                        },
                      ),
                      state is ListProductsBlankState 
                      ? Column(
                        children: [
                          Center(child: CircularProgressIndicator(),),
                          SizedBox(height: 30.h,)
                        ],
                      )
                      : SizedBox.shrink()
                    ],
                  ),
                ),
                
              );
            else
              return Center(child: Text('Пока нет товаров', style: TextStyles.black_14_w400,),);
          }
          return Container();
        }
      ),
    );
  }


}