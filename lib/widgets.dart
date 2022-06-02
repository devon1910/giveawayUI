import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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


alert({required String title, required bool isSuccess, String? btnText = 'Ok', btnFunction }){
   return Alert(
     style: AlertStyle(
       isOverlayTapDismiss: false,
       backgroundColor: Color(0xffF9F0F0),
       animationType: AnimationType.shrink
     ),
      useRootNavigator: false,
      context: Get.context!,
      // type:  type ?? AlertType.error,
      title: title, 
      image: isSuccess ? _alertIcon(Icons.check, green) : _alertIcon(Icons.close, red),
      // Image.asset(
      //   "assets/finalcheck.png",
      //   color: Colors.blue,),
      buttons: [
        DialogButton(
          border: const Border.fromBorderSide(BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 1, style: BorderStyle.solid)),
          color: Color(0xffF9F0F0),
          child: Text(
            isSuccess ? btnText! : 'Try Again',
            style: TextStyle(color: primaryColor, fontSize: 14, fontWeight:  FontWeight.w500),
          ),
          onPressed: btnFunction ?? () => Get.back(),
          width: 120,
        )
      ],
    ).show();}
  
Widget _alertIcon(IconData icon, color){
  return Container(
    width: 80, height: 80, 
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: primaryColor.withOpacity(.2)),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container( 
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: color),
        child: Icon(icon, size: 35, color: white),),
    )
  );
}