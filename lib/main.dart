import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:giveawayui/routes.dart';
import 'package:giveawayui/screens/onboarding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:giveawayui/screens/splash_screen.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
     // home: SplashScreen(),
      initialRoute: OnBoarding.routeName,
      routes: routes,
    theme: ThemeData(
    // Define the default brightness and colors.
    scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
      appBarTheme:  AppBarTheme(
          color: Colors.white

      )

    ),
    );}
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Spray.mee',
          style: primaryGiveawayStyle
        )
          ),
      );
  }
}
