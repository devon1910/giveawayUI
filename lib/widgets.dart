import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'colors.dart';

notificationAreaStyle(Color? bg) {
  return SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: bg,
      systemNavigationBarColor: red);
}


kErrorMessage({String? title, String? message}){
  Get.snackbar(title!, message!, backgroundColor: red, colorText: white, snackPosition: SnackPosition.BOTTOM, borderRadius: 0, margin: EdgeInsets.all(0),
  forwardAnimationCurve: Curves.fastOutSlowIn);
}

kSuccessMessage({String? title, String? message}){
  Get.snackbar(title!, message!, backgroundColor: primaryColor, colorText: white, snackPosition: SnackPosition.BOTTOM,  borderRadius: 0, margin: EdgeInsets.all(0),
  forwardAnimationCurve: Curves.fastOutSlowIn);
}

Widget loadingDash({double size = 20}){
  return SpinKitDualRing(
          color: Colors.blue,
          size: size,
        );
}