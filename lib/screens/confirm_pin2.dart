import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveawayui/widgets.dart';
import '../constants.dart';
import '../functions.dart';
import '/screens/sign_in_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../http_exception.dart';
import '../size_config.dart';

class ConfirmPin2 extends StatefulWidget {
  static String routeName = "/confirmpin2";

  @override
  _ConfirmPin2State createState() => _ConfirmPin2State();
}

class _ConfirmPin2State extends State<ConfirmPin2> {
  final data = Get.arguments;

  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  String confirmpin = "";
  String token = "";
  String message = "";

  void register() async {
    var body = {
      "email": userModel.user!.email,
      "pin": data['pin'],
    };

    String url = 'https://spray-dev.herokuapp.com/api/users/';
    var response = await httpPost(url: url, header: {
      "Content-Type": "application/json",
      "x-auth-token": userModel.token!
    });

    if (response['status'] != 200) {
      alert(title: 'Unable to set transaction pin', isSuccess: false);
      return;
    }

    print(message);
    alert(title: 'Transaction pin save successful', isSuccess: true);
  }

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
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
    print(data);
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
                      color: Color(0xff000000),
                      fontSize: 25.0,
                      fontWeight: FontWeight.w800)),
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            Text("Please enter your PIN to proceed",
                style: GoogleFonts.titilliumWeb(
                    textStyle: TextStyle(
                        color: Color(0xff485068),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400)),
                textAlign: TextAlign.center),
            SizedBox(height: getProportionateScreenHeight(100.0)),
            Form(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  SizedBox(
                    width: getProportionateScreenWidth(50),
                    child: TextFormField(
                      autofocus: true,
                      onChanged: (value) {
                        confirmpin += value;
                        nextField(value, pin2FocusNode);
                      },
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenWidth(15)),
                        filled: true,
                        fillColor: Color(0xFFFFFF),
                        enabledBorder: OutlineInputBorder(
                            // borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        // focusedBorder:
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(50),
                    child: TextFormField(
                      focusNode: pin2FocusNode,
                      onChanged: (value) {
                        confirmpin += value;
                        nextField(value, pin3FocusNode);
                      },
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenWidth(15)),
                        filled: true,
                        fillColor: Color(0xFFFFFF),
                        enabledBorder: OutlineInputBorder(
                            // borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            //  borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        // focusedBorder:
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(50),
                    child: TextFormField(
                      focusNode: pin3FocusNode,
                      onChanged: (value) {
                        confirmpin += value;
                        nextField(value, pin4FocusNode);
                      },
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenWidth(15)),
                        filled: true,
                        fillColor: Color(0xFFFFFF),
                        enabledBorder: OutlineInputBorder(
                            // borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            //  borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        // focusedBorder:
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(50),
                    child: TextFormField(
                      focusNode: pin4FocusNode,
                      onChanged: (value) {
                        confirmpin += value;
                        pin4FocusNode.unfocus();
                        if (data['pin'] == confirmpin) {
                          register();
                        } else {
                          alert(title: 'Invalid Pin didn\'t match', isSuccess: false);
                        }
                      },
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenWidth(15)),
                        filled: true,
                        fillColor: Color(0xFFFFFF),
                        enabledBorder: OutlineInputBorder(
                            // borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            //  borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        // focusedBorder:
                      ),
                    ),
                  )
                ])),
            SizedBox(height: getProportionateScreenHeight(30.0)),
            Center(
              child: Text(
                message != '' ? '$message  ' : "",
                style: TextStyle(color: Colors.blue),
              ),
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
