import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:giveawayui/screens/dashboard.dart';
import 'package:giveawayui/screens/sign_in_screen.dart';
import 'package:giveawayui/screens/spray_amount.dart';
import 'package:giveawayui/screens/spray_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../http_exception.dart';
import '../size_config.dart';


class VerifyPin extends StatefulWidget {
  const VerifyPin({required this.token,
    required this.ecode,
    required this.amount,
    required this.times});

  final String token;
  final String? ecode;
  final  amount;
  final  times;

  @override
  _VerifyPinState createState() => _VerifyPinState();
}

class _VerifyPinState extends State<VerifyPin> {
  late FocusNode  pin2FocusNode;
  late FocusNode  pin3FocusNode;
  late FocusNode  pin4FocusNode;
  String confirmpin="";
  String message="";
  String savedPin="";
  void getPin() async{
     final response = await http.get(
   Uri.parse('https://spray-dev.herokuapp.com/api/users/'),
   headers:{
     'x-auth-token': widget.token,
  }
 );

     if (response.statusCode != 200) {
       throw HTTPException(response.statusCode, "Unable to fetch data...");
     }
    final responseJson =  jsonDecode(response.body);
     print(responseJson['data']['pin']);
     print('CONFIRM PIN: '+ confirmpin + 'LENGTH :'+ confirmpin.length.toString());
     setState(() {
       savedPin=responseJson['data']['pin'];
     });

     checkPin();
     print(responseJson);
  }
  void checkPin() async{
      print('Before comparison-confirm = '+ confirmpin);
      print('Before Comparison-saved = '+ savedPin);
      if(savedPin!=confirmpin){
        Alert(
          useRootNavigator:false,
          context: context,
          type: AlertType.error,
          desc: "Invalid Pin!",
          buttons: [
            DialogButton(
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
      else{
        pushNewScreenWithRouteSettings(
          context,
          settings: RouteSettings(name: SprayScreen.routeName),
          screen: SprayScreen(
            token: widget.token,
            times: widget.times,
            amount: widget.amount,
            ecode: widget.ecode,
          ),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPin();
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
    // TODO: implement dispose
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
              'Confirm Pin',
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      color: Color(0xff000000), fontSize: 25.0, fontWeight: FontWeight.w800)),),
            SizedBox(height: getProportionateScreenHeight(15)),
            Text("Please enter your PIN to proceed",
                style: GoogleFonts.titilliumWeb(
                    textStyle: TextStyle(
                        color: Color(0xff485068), fontSize: 15.0, fontWeight: FontWeight.w400)) ,
                textAlign: TextAlign.center),
            SizedBox(height: getProportionateScreenHeight(100.0)),
            Form(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                      SizedBox(
                        width: getProportionateScreenWidth(50),
                        child: TextFormField(

                          autofocus: true,
                          onChanged: (value){
                            confirmpin+=value;
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
                            confirmpin+=value;
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
                            confirmpin+=value;
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
                            confirmpin+=value;
                            pin4FocusNode.unfocus();
                            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                              content: Text("Processing data"),
                              duration: Duration(milliseconds: 4000), ), );
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
            ),
      ]),
      ),
    );
  }
}

