// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
// import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';
// import 'package:shopv1deliveryfood_mobile/core/utils/toasts.dart';
// import 'package:shopv1deliveryfood_mobile/core/widgets/btns/primary_btn.dart';
// import 'package:shopv1deliveryfood_mobile/core/widgets/cards/category_card.dart';
// import 'package:shopv1deliveryfood_mobile/core/widgets/cards/product_card.dart';
// import 'package:shopv1deliveryfood_mobile/core/widgets/loaders/loader_v1.dart';
// import 'package:shopv1deliveryfood_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
// import 'package:shopv1deliveryfood_mobile/features/favorites/presentation/bloc/favorite/favorite_bloc.dart';
// import 'package:shopv1deliveryfood_mobile/features/home/presentation/bloc/home/home_bloc.dart';
// import 'package:shopv1deliveryfood_mobile/features/home/presentation/widgets/head_carousel.dart';
// import 'package:shopv1deliveryfood_mobile/features/list_products/presentation/views/list_products_view.dart';
// import 'package:shopv1deliveryfood_mobile/features/product_details/presentation/views/product_details_view.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'dart:math' as math;
// class HomeViewV2 extends StatefulWidget {
//   HomeViewV2({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _HomeViewV2State createState() => _HomeViewV2State();
// }

// class _HomeViewV2State extends State<HomeViewV2> with SingleTickerProviderStateMixin {
//   late final TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverPersistentHeader(
//             floating: true,
//             delegate: SliverAppBarDelegate(
//               minHeight: 60,
//               maxHeight: 200,
//               child: Container(
//                 color: Colors.white,
//                 child: Column(
//                   children: [
//                     SizedBox(height: 15.h,),
//                     HeadCarousel(urls: [
//                       // 'https://elements-cover-images-0.imgix.net/b7baf8c8-ba17-4e35-9865-0fdeb552e7cf?auto=compress&crop=edges&fit=crop&fm=jpeg&h=630&w=1200&s=beffa2284fb0f3a624c1949831af34d7', 
//                       // 'https://graphicsfamily.com/wp-content/uploads/edd/2020/11/Tasty-Food-Web-Banner-Design-scaled.jpg', 
//                       // 'https://cdn.dribbble.com/users/5874456/screenshots/14313617/media/aad1c88ba7c6efb9d87b857a73d4c15c.jpg?compress=1&resize=400x300'
//                       '','',''
//                     ],),
//                     SizedBox(height: 15.h,),
//                   ],
//                 ),
//               )
//             ),
//           ),
//           SliverPersistentHeader(
//             pinned: true,
//             delegate: SliverAppBarDelegate(
//               minHeight: 45.h,
//               maxHeight: 45.h,
//               child: Container(
//                 height: 45.h,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(blurRadius: 1, color: Colors.black12),
//                     BoxShadow(blurRadius: 4, color: Colors.black12),
//                   ]
//                 ),
//                 child: ListView(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     Container(
//                       alignment: Alignment.center,
//                       height: 45.h,
//                       margin: EdgeInsets.only(right: 10),
//                       child: Text('Category', style: TextStyles.black_18_w700)
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate((context, index) {
//               return ListTile(
//                 title: Text('List Tile $index'),
//               );
//             }, childCount: 100),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   SliverAppBarDelegate({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.child,
//   });
//   final double minHeight;
//   final double maxHeight;
//   final Widget child;

//   @override
//   double get minExtent => minHeight;
//   @override
//   double get maxExtent => math.max(maxHeight, minHeight);
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return SizedBox.expand(child: child);
//   }

//   @override
//   bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
//     return maxHeight != oldDelegate.maxHeight ||
//         minHeight != oldDelegate.minHeight ||
//         child != oldDelegate.child;
//   }
// }
