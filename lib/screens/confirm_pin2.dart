import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:giveawayui/screens/dashboard.dart';
import 'package:giveawayui/screens/sign_in_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../http_exception.dart';
import '../size_config.dart';


class ConfirmPin2 extends StatefulWidget {
  static String routeName="/confirmpin2";
  const ConfirmPin2({required this.fullname,required this.username,
    required this.email, required this.phone,required this.password,required this.pin});
  final String fullname,username,email,password,pin,phone;
  @override
  _ConfirmPin2State createState() => _ConfirmPin2State();
}


class _ConfirmPin2State extends State<ConfirmPin2> {
  late FocusNode  pin2FocusNode;
  late FocusNode  pin3FocusNode;
  late FocusNode  pin4FocusNode;
  String confirmpin="";
  String token="";
  String message="";
  Future<dynamic> register() async{
    var body = {
      "fullname": widget.fullname,
      "username": widget.username,
      "email": widget.email,
      "password": widget.password,
      "phone": widget.phone,
      "pin": widget.pin,
    };
    var response = await http.post(
        Uri.parse('https://spray-dev.herokuapp.com/api/users/'),
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json"
        });

    if (response.statusCode != 201) {
      throw HTTPException(response.statusCode, "Unable to input data...");
    }
    var responseJson =  jsonDecode(response.body);
    setState(() {
      message=responseJson["message"];
    });
    print(message);
    return message;


    //AUTHENTICATE WITH NEW USER DETAILS TO GET TOKEN
    // body = {
    //   "email": widget.email,
    //   "password": widget.password,
    // };
    // print(widget.email);
    // print(widget.password);
    //  response = await http.post(
    //     Uri.parse('https://spray-dev.herokuapp.com/api/users/auth/'),
    //     body: json.encode(body),
    //     headers: {
    //       "Content-Type": "application/json"
    //     });
    //
    // if (response.statusCode != 200) {
    //   throw HTTPException(response.statusCode, "Unable to load...Try again");
    // }
    // responseJson =  jsonDecode(response.body);
    // token=responseJson["data"];
    // print(token);
    pushNewScreenWithRouteSettings(
      context,
      settings: RouteSettings(name: Dashboard.routeName),
      screen: Dashboard(token: token),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
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
                            if(widget.pin==confirmpin){
                              register();

                            }
                            else{
                              Alert(
                                context: context,
                                type: AlertType.error,
                               // title: "RFLUTTER ALERT",
                                desc: "Invalid Pin. Doesn't match",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            }
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
            SizedBox(height: getProportionateScreenHeight(30.0)),
            Center(
              child: Text(message!='' ? '$message  ' : "",
              style: TextStyle(
                color: Colors.blue
              ),),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },
                child: Text("Sign in"),
              ),
            )

          ],
        ),
      ),
    );
  }
}


