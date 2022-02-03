import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/DefaultButton.dart';
import 'package:giveawayui/constants.dart';
import 'package:giveawayui/screens/sign_in_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config.dart';
import 'confirm_pin.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName="/signUp";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String fullname="",username="",email="",phone="",password="";
  final _formKey = GlobalKey<FormState>();

  void _submit(){
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text("Processing data"),
        duration: Duration(milliseconds: 300), ), );
      Navigator.of(context).push(
          MaterialPageRoute(
              builder:(context)=> ConfirmPin(fullname: fullname,
                username: username, email: email, phone: phone, password: password,)));
    }else{
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(top:200),
        color: Color(0xFF3F51B5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Container(  
                  padding: EdgeInsets.fromLTRB(30,60,30,10),
                  child: Text("Hurry Chief",
                   style: GoogleFonts.nunito(
                       textStyle: TextStyle(
                           color: Color(0xFFFFFFFF), fontSize: 45.0, fontWeight: FontWeight.w800))),
                ),
                Container(
                  padding: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                      color:  Colors.white,
                      borderRadius:BorderRadius.only(topLeft: Radius.circular(40),topRight:Radius.circular(40) )
                  ),
                  width: double.infinity,
                  //height: getProportionateScreenHeight(150),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                              'Sign Up',
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      color: Color(0xff000099), fontSize: 30.0, fontWeight: FontWeight.w800))
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          height: 20.0,
                          thickness: 0.5,
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fullname',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400))),
                            SizedBox(height:getProportionateScreenHeight(10)),
                            TextFormField(
                              onChanged: (value){
                                fullname=value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  fontSize: 20.0
                                //      backgroundColor: Color(0xFFE4E4E4)
                              ),
                              // keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE4E4E4),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,),
                                //hintText: 'someone@example.com',
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
                            SizedBox(height:getProportionateScreenHeight(10)),
                            Text('Username',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400))),
                            SizedBox(height:getProportionateScreenHeight(10)),
                            TextFormField(
                              onChanged: (value){
                                username=value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Username';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  fontSize: 20.0
                                //      backgroundColor: Color(0xFFE4E4E4)
                              ),
                              // keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE4E4E4),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,),
                                //hintText: 'someone@example.com',
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
                            SizedBox(height:getProportionateScreenHeight(10)),
                            Text('Email Address',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(

                                        color: Color(0xff000000),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400))),
                            SizedBox(height:getProportionateScreenHeight(10)),
                            TextFormField(
                              onChanged: (value){
                                email=value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  fontSize: 20.0
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
                            SizedBox(height:getProportionateScreenHeight(10)),
                            //SizedBox(height:getProportionateScreenHeight(10)),
                            Text('Phone number',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(

                                        color: Color(0xff000000),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400))),
                            SizedBox(height:getProportionateScreenHeight(10)),
                            TextFormField(
                              onChanged: (value){
                                phone=value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  fontSize: 20.0
                                //      backgroundColor: Color(0xFFE4E4E4)
                              ),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE4E4E4),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.mail_outline,
                                  color: Colors.black,),
                                hintText: 'phone number',
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
                            SizedBox(height:getProportionateScreenHeight(10)),
                            Text('Password',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400))),
                            SizedBox(height:getProportionateScreenHeight(10)),
                            TextFormField(
                              onChanged: (value){
                                password=value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid password';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                //  backgroundColor: Color(0xFFE4E4E4)
                              ),
                              obscureText: true,
                              // keyboardType: TextInputType.p,
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE4E4E4),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.black,),
                                suffixIcon: Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.black
                                ),
                                hintText: '********',
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
                            SizedBox(height: getProportionateScreenHeight(25)),
                            DefaultButton(
                              text: "Sign Up",
                              press: () => _submit()
                            ),
                            SizedBox(height: getProportionateScreenHeight(10)),
                            Container(
                              margin:EdgeInsets.only(left:60.0),
                              child: Row(
                                children:[
                                  Text('Already have an account?',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.titilliumWeb(
                                          textStyle: TextStyle(
                                              color: Color(0xFF3F51B5), fontSize: 20.0, fontWeight: FontWeight.w400))

                                  ),
                                  SizedBox( width: getProportionateScreenWidth(10),),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, SignInScreen.routeName);
                                    },
                                    child: Text('Sign In',
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.titilliumWeb(
                                            textStyle: TextStyle(
                                                color: Color(0xFF3F51B5), fontSize: 20.0, fontWeight: FontWeight.w600))

                                    ),
                                  ),
                              ]),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
