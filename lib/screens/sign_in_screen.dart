
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors.dart';
import '../widgets.dart';
import '/components/DefaultButton.dart';
import '/screens/forgot_password.dart';
import '/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller/sign_in_controller.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/signIn";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            GetBuilder<SigninControler>(
                init: SigninControler(),
                initState: (_) {},
                builder: (controller) {
                  return Container(
                      // padding: EdgeInsets.only(top:200),
                      color: Color(0xFF3F51B5),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          SizedBox(
                              width: double.infinity,
                              child: Image.asset(
                                "assets/image1.png",
                                scale: 1.4,
                                width: double.infinity,
                                height: getProportionateScreenHeight(300),
                              )),
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
                              key: controller.formKey,
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Text('Sign In',
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
                                  SizedBox(
                                      height: getProportionateScreenHeight(20)),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Email Address',
                                          style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                  color: Color(0xff000000),
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w400))),
                                      SizedBox(
                                          height: getProportionateScreenHeight(10)),
                                      TextFormField(
                                        controller: controller.email,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        //    onChanged: (value){
                                        //      con
                                        //  } ,
                                        style: TextStyle(
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
                                      SizedBox(
                                          height: getProportionateScreenHeight(15)),
                                      Text('Password',
                                          style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                  color: Color(0xff000000),
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w400))),
                                      SizedBox(
                                          height: getProportionateScreenHeight(10)),
                                      TextFormField(
                                        controller: controller.password,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        //  onChanged: (value){
                                        //    password= value;
                                        //  },
                                        style: TextStyle(
                                          color: Colors.black,
                                          //  backgroundColor: Color(0xFFE4E4E4)
                                        ),
                                        obscureText: controller.obscure,
                                        // keyboardType: TextInputType.p,
                                        decoration: InputDecoration(
                                          fillColor: Color(0xFFE4E4E4),
                                          filled: true,
                                          prefixIcon: Icon(
                                            Icons.lock_outline,
                                            color: Colors.black,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(controller.obscure
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                            color: Colors.black,
                                            onPressed: () {
                                              setState(() {
                                                controller.obscure =
                                                    !controller.obscure;
                                              });
                                            },
                                          ),
                                          hintText: '**********',
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
                                      SizedBox(
                                          height: getProportionateScreenHeight(15)),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, ForgotPassword.routeName);
                                          },
                                          child: Text('Forgot Password?',
                                              style: GoogleFonts.nunito(
                                                  textStyle: TextStyle(
                                                      color: Color(0xff000000),
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w700))),
                                        ),
                                      ),
                                      SizedBox(
                                          height: getProportionateScreenHeight(45)),
                                      controller.isLoading
                                          ? loadingDash() 
                                          // Center(
                                          //   child: Container(
                                          //       width: 10,
                                          //       height: 10,
                                          //       child: CircularProgressIndicator(
                                          //         color: primaryColor,
                                          //       )),
                                          // )
                                          : DefaultButton(
                                              text: "Sign In",
                                              press: controller.submit,
                                            )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ));
                }),
          SafeArea(child: GestureDetector(
                onTap: ()=> Get.back(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 12),
                  child: Icon(Icons.arrow_back_ios, color: white),
                ),
              )),
            ],
        ));
  }
}
