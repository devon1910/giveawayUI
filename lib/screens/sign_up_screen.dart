import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveawayui/colors.dart';
import 'package:giveawayui/widgets.dart';
import '../functions.dart';
import '/components/DefaultButton.dart';
import '/screens/sign_in_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config.dart';
import 'confirm_pin.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/signUp";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fullName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      isLoading.value = true;
      Map<String, String> body = {
        "fullname": fullName.text,
        "username": username.text,
        "email": email.text,
        "password": password.text,
        "phone": phone.text,
      };

      var url = 'https://spray-dev.herokuapp.com/api/users/';
      Map<String, dynamic> response = await httpPost(url: url, body: body);
      if (response['status'] != 201) {
        // print("an error occurred");
        alert(title: response['message'].toString(), isSuccess: false);
        isLoading.value = false;
        return;
      }

      // print("all went well");
      alert(title: response['message'].toString(), isSuccess: true);
      fullName.clear();
      username.clear();
      email.clear();
      password.clear();
      phone.clear();
      isLoading.value = false;
    }
  }

  RxBool hide = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(top:200),
        color: Color(0xFF3F51B5),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SafeArea(
                  child: GestureDetector(
                onTap: () => Get.back(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 12),
                  child: Icon(Icons.arrow_back_ios, color: white),
                ),
              )),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: EdgeInsets.fromLTRB(30, 60, 30, 10),
                  child: Text("Hurry Chief",
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 45.0,
                              fontWeight: FontWeight.w800))),
                ),
                Container(
                  padding: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  width: double.infinity,
                  //height: getProportionateScreenHeight(150),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text('Sign Up',
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      color: Color(0xff000099),
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w800))),
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
                            SizedBox(height: getProportionateScreenHeight(10)),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Full name is required';
                                }
                                return null;
                              },
                              style: TextStyle(fontSize: 20.0),
                              controller: fullName,
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE4E4E4),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                hintText: 'full name',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 1),
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
                            SizedBox(height: getProportionateScreenHeight(10)),
                            Text('Username',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400))),
                            SizedBox(height: getProportionateScreenHeight(10)),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Username';
                                }
                                return null;
                              },
                              controller: username,
                              style: TextStyle(fontSize: 20.0
                                  //      backgroundColor: Color(0xFFE4E4E4)
                                  ),
                              // keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE4E4E4),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                hintText: 'username',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 1),
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
                            SizedBox(height: getProportionateScreenHeight(10)),
                            Text('Email Address',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400))),
                            SizedBox(height: getProportionateScreenHeight(10)),
                            TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              controller: email,
                              style: TextStyle(fontSize: 20.0
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
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 1),
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
                            SizedBox(height: getProportionateScreenHeight(10)),
                            //SizedBox(height:getProportionateScreenHeight(10)),
                            Text('Phone number',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400))),
                            SizedBox(height: getProportionateScreenHeight(10)),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                              controller: phone,
                              style: TextStyle(fontSize: 20.0
                                  //      backgroundColor: Color(0xFFE4E4E4)
                                  ),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE4E4E4),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.mail_outline,
                                  color: Colors.black,
                                ),
                                hintText: 'phone number',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 1),
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
                            SizedBox(height: getProportionateScreenHeight(10)),
                            Text('Password',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400))),
                            SizedBox(height: getProportionateScreenHeight(10)),
                            Obx(() => TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid password';
                                    }
                                    return null;
                                  },
                                  controller: password,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    //  backgroundColor: Color(0xFFE4E4E4)
                                  ),
                                  obscureText: hide.value,
                                  // keyboardType: TextInputType.p,
                                  decoration: InputDecoration(
                                    fillColor: Color(0xFFE4E4E4),
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.black,
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () => hide.toggle(),
                                      child: Icon(
                                          hide.value
                                              ? Icons.remove_red_eye_outlined
                                              : Icons.remove_red_eye,
                                          color: Colors.black),
                                    ),
                                    hintText: '********',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 1, vertical: 1),
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
                                )),
                            SizedBox(height: getProportionateScreenHeight(25)),
                            Obx(() => isLoading.value
                                ? Center(child: loadingDash())
                                : DefaultButton(
                                    text: "Sign Up", press: () => _submit())),
                            SizedBox(height: getProportionateScreenHeight(10)),
                            Center(
                              child: Container(
                                //margin:EdgeInsets.only(left:60.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Already have an account?',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.titilliumWeb(
                                              textStyle: TextStyle(
                                                  color: Color(0xFF3F51B5),
                                                  fontSize: 20.0,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                      SizedBox(
                                        width: getProportionateScreenWidth(10),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, SignInScreen.routeName);
                                        },
                                        child: Text('Sign In',
                                            textAlign: TextAlign.right,
                                            style: GoogleFonts.titilliumWeb(
                                                textStyle: TextStyle(
                                                    color: Color(0xFF3F51B5),
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
