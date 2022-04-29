import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/screens/landing_screen.dart';

class SplashScreen extends StatefulWidget {

  SplashScreen({required this.token});

  final String? token;
  static String routeName="/splash";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: LandingScreen(),
    );
  }
}




