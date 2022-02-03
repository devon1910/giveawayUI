import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/DefaultButton.dart';
import 'package:giveawayui/screens/confirm_pin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../size_config.dart';

class Amount extends StatefulWidget {
  static String routeName="/amount";
  @override
  _AmountState createState() => _AmountState();
}

class _AmountState extends State<Amount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
    children: [
    Container(
    margin: EdgeInsets.only(top: 40.0),
    child: Center(
    child: Text('Amount',
    style: GoogleFonts.nunito(
    textStyle: TextStyle(
    color: Color(0xff3F51B5), fontSize: 36.0, fontWeight: FontWeight.w800)) ,),
    ),
    ),
    Center(
    child: Text('Enter the amount you want to send',
    style: GoogleFonts.nunito(
    textStyle: TextStyle(
    color: Color(0xff243656), fontSize: 20.0, fontWeight: FontWeight.w400)),)),
    SizedBox(height: getProportionateScreenHeight(20.0)),
    Text('Amount',
        style: GoogleFonts.nunito(
            textStyle: TextStyle(
                color: Color(0xff000000),
                fontSize: 14.0,
                fontWeight: FontWeight.w400))),
    SizedBox(height:getProportionateScreenHeight(20)),
    Container(
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextFormField(
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
      SizedBox(height:getProportionateScreenHeight(100)),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 40.0),
        child: DefaultButton(text: 'Next', press: (){
            // pushNewScreenWithRouteSettings(
            //   context,
            //   settings: RouteSettings(name: ConfirmPin.routeName),
            //   screen: ConfirmPin(),
            //   withNavBar: true,
            //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
            // );
          }
        ),
      )
   ] )
    );
  }
}
