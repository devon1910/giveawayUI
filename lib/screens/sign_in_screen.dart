import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/DefaultButton.dart';
import 'package:giveawayui/components/loadDash.dart';
import 'package:giveawayui/components/spray.dart';
import 'package:giveawayui/screens/forgot_password.dart';
import 'package:giveawayui/screens/sign_up_screen.dart';
import 'package:giveawayui/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../http_exception.dart';
import 'dashboard.dart';

class SignInScreen extends StatefulWidget {
  static String routeName="/signIn";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();
  bool status=false;
  String email="";
  String password="";
  String token="";
  bool _obscureText = true;
  void _submit() async{
    if (_formKey.currentState!.validate()) {
      var body = {
        "email": email,
        "password": password,
      };
      print(email);
      print(password);
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text("Loading..."),
        duration: Duration(milliseconds: 5000), ), );
      var response = await http.post(
          Uri.parse('https://spray-dev.herokuapp.com/api/users/auth/'),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json"
          });

      if (response.statusCode != 200) {
        Alert(
          useRootNavigator: false,
          context: context,
          type: AlertType.error,
          title: "ERROR",
          desc: "Invalid login details. Try again",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        throw HTTPException(response.statusCode, "Unable to load...Try again");

      }
      final responseJson =  jsonDecode(response.body);
      token=responseJson["data"];
      print(token);
      Navigator.of(context).push(
          MaterialPageRoute(
              builder:(context)=> LoadDash(token: token)));

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
           children:[
             SizedBox(
               width: double.infinity,
                 child: Image.asset("assets/image1.png",
                   width: double.infinity,
                   height: getProportionateScreenHeight(300),)
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
                           'Sign In',
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
                     SizedBox(height: getProportionateScreenHeight(20)),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Email Address',
                             style: GoogleFonts.nunito(
                                 textStyle: TextStyle(
                                     color: Color(0xff000000),
                                     fontSize: 14.0,
                                     fontWeight: FontWeight.w400))),
                         SizedBox(height:getProportionateScreenHeight(10)),
                         TextFormField(
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter some text';
                             }
                             return null;
                           },
                           onChanged: (value){
                             email= value;
                         } ,
                           style: TextStyle(
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
                         SizedBox(height:getProportionateScreenHeight(15)),
                         Text('Password',
                             style: GoogleFonts.nunito(
                                 textStyle: TextStyle(
                                     color: Color(0xff000000),
                                     fontSize: 14.0,
                                     fontWeight: FontWeight.w400))),
                         SizedBox(height:getProportionateScreenHeight(10)),
                         TextFormField(
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter some text';
                             }
                             return null;
                           },
                           onChanged: (value){
                             password= value;
                           },
                           style: TextStyle(
                             color: Colors.black,
                           //  backgroundColor: Color(0xFFE4E4E4)
                           ),
                           obscureText: _obscureText,
                          // keyboardType: TextInputType.p,
                           decoration: InputDecoration(
                             fillColor: Color(0xFFE4E4E4),
                             filled: true,
                             prefixIcon: Icon(
                               Icons.lock_outline,
                               color: Colors.black,),
                             suffixIcon: IconButton(
                                 icon: Icon(
                                     _obscureText ? Icons.visibility_off : Icons.visibility
                                 ),
                                 color: Colors.black,
                               onPressed: () {
                                 setState(() {
                                   _obscureText = !_obscureText;
                                 });
                               },
                             ),
                             hintText: '**********',
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
                         SizedBox(height: getProportionateScreenHeight(15)),
                         Container(
                           margin: EdgeInsets.only(left: getProportionateScreenWidth(210)),
                           child: GestureDetector(
                             onTap: (){
                               Navigator.pushNamed(context, ForgotPassword.routeName);
                             },
                             child: Text('Forgot Password?',
                               style: GoogleFonts.nunito(
                                   textStyle: TextStyle(
                                       color: Color(0xff000000),
                                       fontSize: 14.0,
                                       fontWeight: FontWeight.w700))
                             ),
                           ),
                         ),
                        SizedBox(height: getProportionateScreenHeight(45)),
                        DefaultButton(
                          text: "Sign In",
                          press: _submit,
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



