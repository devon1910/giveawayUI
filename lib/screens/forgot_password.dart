import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/DefaultButton.dart';
import 'package:giveawayui/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:giveawayui/screens/otp.dart';


class ForgotPassword extends StatelessWidget {
  static String routeName="/forgotPassword";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      //  width: double.infinity,
        color: Color(0xFFFFFFFF),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 100.0,right: 30.0,
                    left: 30.0, bottom: 30.0),
                  child: Column(
                      children:[
                        Text(
                          'Forgot Password ?',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff000000), fontSize: 25.0, fontWeight: FontWeight.w800)),),
                                SizedBox(height: getProportionateScreenHeight(10)),
                                Text("Enter your registered email address to \n"
                                    "receive password reset instruction",
                                style: GoogleFonts.titilliumWeb(
                                    textStyle: TextStyle(
                                        color: Color(0xff485068), fontSize: 14.0, fontWeight: FontWeight.w400)) ,
                                textAlign: TextAlign.center,)
                      ]
                  )
              ),
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
                    ] ,
                    color: Colors.white,
                    borderRadius:BorderRadius.only(topLeft: Radius.circular(40),topRight:Radius.circular(40) )
                ),
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
                    SizedBox(height:getProportionateScreenHeight(15)),
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
                        color: Colors.black,),
                      hintText: 'someone@example.com',
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 1,
                          vertical: 1
                      ),
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
                    SizedBox(height:getProportionateScreenHeight(60)),
                    DefaultButton(
                      text: "Reset Password",
                      press: (){
                        Navigator.pushNamed(context, Otp.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
