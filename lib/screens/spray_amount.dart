import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/DefaultButton.dart';
import 'package:giveawayui/screens/confirm_pin.dart';
import 'package:giveawayui/screens/verify_pin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../size_config.dart';
import 'confirm_pin2.dart';

class SprayAmount extends StatefulWidget {
  static String routeName="/spray_amount";
  const SprayAmount({required this.ecode,required this.token});
  final String? ecode;
  final String token;
  @override
  _SprayAmount createState() => _SprayAmount();
}

class _SprayAmount extends State<SprayAmount> {
  String amount="";
  String times="";
  var amountInt;
  var timesInt;
  // assert(myInt is int);
  // print(myInt);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Text('Spray Amount',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff3F51B5), fontSize: 36.0, fontWeight: FontWeight.w800)) ,),
                  ),
                ),
                Center(
                    child: Text('Select the amount you want to send and the\n number of times '
                        'you want to spray',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff243656), fontSize: 14.0, fontWeight: FontWeight.w400)),)),
                SizedBox(height: getProportionateScreenHeight(20.0)),
                Container(
                  margin: EdgeInsets.only(right: getProportionateScreenWidth(250)),
                  child: Text('Amount',
                      //textAlign: TextAlign.left,
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400))),
                ),
                SizedBox(height:getProportionateScreenHeight(5)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    onChanged: (value){
                      amount=value;
                      amountInt= int.parse(amount);
                    },

                    autofocus: true,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xff243656), fontSize: 30.0, fontWeight: FontWeight.w700)),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
//        fillColor: Color(0xFFE4E4E4),
//        filled: true,

                      // hintText: 'someone@example.com',
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff3F51B5)),
                        gapPadding: 10,

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff3F51B5)),
                        gapPadding: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height:getProportionateScreenHeight(20)),
                Container(
                  margin: EdgeInsets.only(right: getProportionateScreenWidth(180)),
                  child: Text('No of times to spray',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400))),
                ),
                SizedBox(height:getProportionateScreenHeight(5)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    onChanged: (value){
                      times = value;
                      timesInt= int.parse(times);
                    },
                    autofocus: true,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xff243656), fontSize: 30.0, fontWeight: FontWeight.w700)),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
//        fillColor: Color(0xFFE4E4E4),
//        filled: true,

                      // hintText: 'someone@example.com',
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff3F51B5)),
                        gapPadding: 10,

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff3F51B5)),
                        gapPadding: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height:getProportionateScreenHeight(50)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: DefaultButton(text: 'Next', press: (){
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: RouteSettings(name: ConfirmPin2.routeName),
                      screen: VerifyPin(
                          token: widget.token,
                          ecode: widget.ecode,
                          amount: amountInt,
                          times: timesInt),
                      withNavBar: true,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                  }
                  ),
                )
              ] ),
        )
    );
  }
}
