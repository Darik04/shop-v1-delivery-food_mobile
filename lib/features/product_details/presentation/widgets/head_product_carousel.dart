import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';


class HeadProductCarousel extends StatefulWidget {
  List<String> urls;
  HeadProductCarousel({Key? key, required this.urls}) : super(key: key);

  @override
  _HeadProductCarouselState createState() => _HeadProductCarouselState();
}

class _HeadProductCarouselState extends State<HeadProductCarousel> {
  int _currentSliderIndex = 1;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1.1,
            
            height: 190.h,
            initialPage: _currentSliderIndex,
            onPageChanged: (int index, CarouselPageChangedReason carousel){
              setState(() {
                _currentSliderIndex = index;
              });
            }
          ),
          
          items: widget.urls.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  // margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: ColorStyles.primary,
                  ),
                  child: ClipRRect(
                    
                    child: Image(
                      image: NetworkImage(i),
                      fit: BoxFit.cover,
                      
                    ),
                  )
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 12.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.urls.map((url) {
            int i = widget.urls.indexOf(url);
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: i == _currentSliderIndex ? ColorStyles.primary : ColorStyles.white,
                border: Border.all(color: ColorStyles.primary, width: 2.w),
                borderRadius: BorderRadius.circular(30),
              ),
            );
          }).toList()
        )
      ],
    );
  }
}