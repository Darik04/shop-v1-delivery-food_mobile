import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/config.dart';


class ProfilePhoto extends StatelessWidget {
  final File? fileImage;
  final String? urlImage;
  final Function() onTap;
  const ProfilePhoto({Key? key, required this.onTap, this.fileImage, this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
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
                  child: fileImage != null
                  ? Image(
                    width: 130,
                    height: 130,
                    fit: BoxFit.cover,
                    image: FileImage(fileImage!),
                  )
                  : urlImage != null
                  ? Image(
                    width: 130,
                    height: 130,
                    fit: BoxFit.cover,
                    image: NetworkImage(Config.url.urlWithoutApi + urlImage!),
                  ) 
                  : Image(
                    width: 130,
                    height: 130,
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
        ),
      ],
    );
  }
}