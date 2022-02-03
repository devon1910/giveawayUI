
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/FlutterProj/giveaway_ui/lib/screens/onboarding.dart';
import 'package:giveawayui/screens/landing_screen.dart';
import 'package:giveawayui/size_config.dart';


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




