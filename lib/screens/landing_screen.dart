import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/screens/sign_in_screen.dart';
import '/screens/sign_up_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../size_config.dart';

class LandingScreen extends StatelessWidget {
  static String routeName = "/landingScreen";
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(Get.context!);
    return SafeArea(
        child: Container(
            color: Color(0xFF3F51B5),
            padding: EdgeInsets.only(
                top: 90.0, right: 50.0, left: 50.0, bottom: 70.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 60.0),
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                          center: Alignment(-0.2, -1),
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0.2),
                            Color.fromRGBO(189, 189, 189, 0),
                          ],
                          radius: 1.0),
                  //  color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Spray.mee',
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Color(0xffffffff),
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.w800)),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                        //  mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset('assets/Vector-3.png'),
                            Image.asset('assets/Vector-2.png'),
                            Image.asset('assets/Vector.png',
                              width: getProportionateScreenWidth(110)),
                          ],
                        )
                      ]),
                ),
              ),
              SizedBox(height: 70.0),
              SizedBox(
                height: getProportionateScreenHeight(60),
                width: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Color(0xFF3F51B5)))),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  },
                  child: Text(
                    "Sign In",
                    style: nextButtonStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?       ',
                      style: GoogleFonts.titilliumWeb(
                        textStyle: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color(0xffffffff),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600),
                      ),
                      textAlign: TextAlign.center),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    child: Text('Sign Up',
                        style: GoogleFonts.titilliumWeb(
                          textStyle: TextStyle(
                              decoration: TextDecoration.none,
                              color: Color(0xffffffff),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700),
                        ),
                        textAlign: TextAlign.center),
                  )
                ],
              )
            ])));
  }
}
