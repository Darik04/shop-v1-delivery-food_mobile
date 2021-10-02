import 'dart:io';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopv1deliveryfood_mobile/constants/colors/color_styles.dart';

void showAlertToast(String msg) {
  Fluttertoast.showToast(
      msg: '$msg',
      gravity: ToastGravity.CENTER,
      backgroundColor: ColorStyles.red_failure,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      fontSize: 16);
}
