import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/DefaultButton.dart';
import 'package:giveawayui/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/loadDash.dart';


class UpdateProfile extends StatefulWidget {
  static String routeName="/resetUsername";
  UpdateProfile({required this.token, required this.parameter,required this.icon,this.keypadType});
  final String token;
  final String parameter;
  final IconData icon;
  TextInputType? keypadType;

  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String newValue="";
  void updateUserProfile() async{
    String resetUrl= "https://spray-dev.herokuapp.com/api/users/";
    var body = {
      "${widget.parameter}": newValue
    };
    var response = await http.put(
        Uri.parse(resetUrl),
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
          "x-auth-token": widget.token
        });
    if(response.statusCode==200){
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text("Loading..."),
        duration: Duration(milliseconds: 4000), ), );
      Alert(
        useRootNavigator: false,
        context: context,
        title: "${widget.parameter} Updated",
        //desc: "",
        image: Image.asset(
            "assets/finalcheck.png",
            color: Colors.green),
        buttons: [
          DialogButton(
            color: Colors.blue,
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            onPressed: () {
              pushNewScreen(
                  context,
                  //  settings: RouteSettings(name: CreateEvent.routeName),
                  screen: LoadDash(
                    ),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino);
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
                            'Reset ${widget.parameter} ',
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    color: Color(0xff000000), fontSize: 25.0, fontWeight: FontWeight.w800)),),
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
                      Text('${widget.parameter}',
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400))),
                      SizedBox(height:getProportionateScreenHeight(15)),
                      TextFormField(
                        onChanged: (value){
                          newValue= value;
                        },
                        autofocus: true,
                        style: TextStyle(
                            fontSize: 22.0
                          //      backgroundColor: Color(0xFFE4E4E4)
                        ),
                        keyboardType: widget.keypadType,
                        decoration: InputDecoration(
                          fillColor: Color(0xFFE4E4E4),
                          filled: true,
                          prefixIcon: Icon(
                            widget.icon,
                            color: Colors.black,),
                          // hintText: 'someone@example.com',
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
                        text: "Reset ${widget.parameter}",
                        press: (){
                          updateUserProfile();
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
