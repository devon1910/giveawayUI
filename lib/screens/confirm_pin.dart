
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveawayui/screens/confirm_pin2.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config.dart';


class ConfirmPin extends StatefulWidget {
  static String routeName="/confirmpin";

  @override
  _ConfirmPinState createState() => _ConfirmPinState();
}


class _ConfirmPinState extends State<ConfirmPin> {

  bool arg = Get.arguments;

  late FocusNode  pin2FocusNode;
  late FocusNode  pin3FocusNode;
  late FocusNode  pin4FocusNode;
  String pin="";

  @override
  void initState() {
    super.initState();
    pin2FocusNode =FocusNode();
    pin3FocusNode =FocusNode();
    pin4FocusNode =FocusNode();
  }

  void nextField(String value, FocusNode focusNode){
    if(value.length==1){
      focusNode.requestFocus();
    }
  }
  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(40, 80, 40, 20),
        //width: double.infinity,
        child: Column(
          children: [
            Text(
             arg ? 'Please Setup Your Transaction Pin' : 'Verification Required',
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      color: Color(0xff000000), fontSize: 25.0, fontWeight: FontWeight.w800)),textAlign: TextAlign.center,),
            SizedBox(height: getProportionateScreenHeight(15)),
            Text(arg ? 'Please enter your preferred PIN to proceed' : "Please enter your PIN to proceed",
                style: GoogleFonts.titilliumWeb(
                    textStyle: TextStyle(
                        color: Color(0xff485068), fontSize: 15.0, fontWeight: FontWeight.w400)) ,
                textAlign: TextAlign.center),
            SizedBox(height: getProportionateScreenHeight(150.0)),
            Form(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                      SizedBox(
                        width: getProportionateScreenWidth(50),
                        child: TextFormField(

                          autofocus: true,
                          onChanged: (value){
                            pin+=value;
                            nextField(value, pin2FocusNode);
                          },
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenWidth(15)
                            ),
                            filled: true,
                            fillColor: Color(0xFFFFFF),
                            enabledBorder: OutlineInputBorder(
                              // borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            // focusedBorder:
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(50),
                        child: TextFormField(
                          focusNode: pin2FocusNode,
                          onChanged: (value){
                            pin+=value;
                            nextField(value,pin3FocusNode);

                          },
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenWidth(15)
                            ),
                            filled: true,
                            fillColor: Color(0xFFFFFF),
                            enabledBorder: OutlineInputBorder(
                              // borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            focusedBorder: OutlineInputBorder(
                              //  borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            // focusedBorder:
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(50),
                        child: TextFormField(
                          focusNode: pin3FocusNode,
                          onChanged: (value){
                            pin+=value;
                            nextField(value,pin4FocusNode);
                          },
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenWidth(15)
                            ),
                            filled: true,
                            fillColor: Color(0xFFFFFF),
                            enabledBorder: OutlineInputBorder(
                              // borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            focusedBorder: OutlineInputBorder(
                              //  borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            // focusedBorder:
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(50),
                        child: TextFormField(
                          focusNode: pin4FocusNode,
                          onChanged: (value){
                            pin+=value;
                            pin4FocusNode.unfocus();
                            Get.toNamed("/confirmpin2", arguments: {'pin': pin});
                          },
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenWidth(15)
                            ),
                            filled: true,
                            fillColor: Color(0xFFFFFF),
                            enabledBorder: OutlineInputBorder(
                              // borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            focusedBorder: OutlineInputBorder(
                              //  borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            // focusedBorder:
                          ),
                        ),
                      )
                    ]
                )
            )
          ],
        ),
      ),
    );
  }
}


