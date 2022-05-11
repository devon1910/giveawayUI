import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import '/routes.dart';
import '/screens/onboarding.dart';
import 'package:google_fonts/google_fonts.dart';
import '/screens/splash_screen.dart';
import 'app_settings.dart';
import 'components/loadDash.dart';
import 'constants.dart';
import 'screens/dashboard.dart';
import 'screens/landing_screen.dart';
import 'size_config.dart';

void main() async {
  generalAppSettings = AppSettings.instance;
  await generalAppSettings.initializeSettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: appSettings['onBoarding'] ? OnBoarding.routeName : appSettings['isLogin'] ? Dashboard.routeName : LandingScreen.routeName ,
      routes: routes,
      theme: ThemeData(
          // Define the default brightness and colors.
          scaffoldBackgroundColor: Colors.white,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          appBarTheme: AppBarTheme(color: Colors.white)),
    );
  }
}
