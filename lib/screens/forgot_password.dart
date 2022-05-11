import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giveawayui/constants.dart';
import '../colors.dart';
import '../widgets.dart';
import '/components/DefaultButton.dart';
import '/screens/sign_in_screen.dart';
import '/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import '/screens/otp.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static String routeName = "/forgotPassword";
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String resetPasswordUrl =
      "https://spray-dev.herokuapp.com/api/users/forgot-password";
  void resetPassword() async {
    var response = await http.post(Uri.parse(resetPasswordUrl), headers: {
      "Content-Type": "application/json",
      // "x-auth-token": widget.token
    });
    if (response.statusCode == 200) {
      Alert(
        useRootNavigator: false,
        context: context,
        title: "Password reset link sent, Please check your mail.",
        //desc: "",
        image: Image.asset(
          "assets/finalcheck.png",
          color: Colors.blue,
        ),
        buttons: [
          DialogButton(
            color: Colors.blue,
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            onPressed: () {
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: notificationAreaStyle(white),
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              // notificationAreaStyle(primaryColor);
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            )),
      ),
      body: Container(
        //  width: double.infinity,
        color: Color(0xFFFFFFFF),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    top: 100.0, right: 30.0, left: 30.0, bottom: 30.0),
                child: Column(children: [
                  Text(
                    'Forgot Password ?',
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800)),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Text(
                    "Enter your registered email address to \n"
                    "receive password reset instruction",
                    style: GoogleFonts.titilliumWeb(
                        textStyle: TextStyle(
                            color: Color(0xff485068),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400)),
                    textAlign: TextAlign.center,
                  )
                ])),
            Container(
              height: getProportionateScreenHeight(600),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              padding: EdgeInsets.all(40.0),
              width: double.infinity,
              //  height: getProportionateScreenHeight(30),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height:getProportionateScreenHeight(15)),
                  Text('Email Address',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400))),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  TextFormField(
                    style: TextStyle(
                        //      backgroundColor: Color(0xFFE4E4E4)
                        ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Color(0xFFE4E4E4),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.black,
                      ),
                      hintText: 'someone@example.com',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                        // borderSide: BorderSide(color: Colors.red)
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        // borderSide: BorderSide(color: Colors.red)
                        gapPadding: 10,
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(60)),
                  DefaultButton(
                    text: "Reset Password",
                    press: () {
                      Navigator.pushNamed(context, Otp.routeName);
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
