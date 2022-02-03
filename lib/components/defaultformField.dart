// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../size_config.dart';
//
// class DefaultTextFormField  extends StatelessWidget {
//   final String text="";
//   final VoidCallback press;
//   const DefaultTextFormField({
// })
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//      children: [
//        Text('Email Address',
//            style: GoogleFonts.nunito(
//                textStyle: TextStyle(
//                    color: Color(0xff000000),
//                    fontSize: 14.0,
//                    fontWeight: FontWeight.w400))),
//        SizedBox(height:getProportionateScreenHeight(10)),
//        TextFormField(
//          onChanged: press ,
//          style: TextStyle(
//            //      backgroundColor: Color(0xFFE4E4E4)
//          ),
//          keyboardType: TextInputType.emailAddress,
//          decoration: InputDecoration(
//            fillColor: Color(0xFFE4E4E4),
//            filled: true,
//            prefixIcon: Icon(
//              Icons.mail_outline,
//              color: Colors.black,),
//            hintText: 'someone@example.com',
//            contentPadding: EdgeInsets.symmetric(
//                horizontal: 1,
//                vertical: 1
//            ),
//            enabledBorder: OutlineInputBorder(
//              borderSide: BorderSide.none,
//              borderRadius: BorderRadius.circular(10),
//              // borderSide: BorderSide(color: Colors.red)
//              gapPadding: 10,
//
//            ),
//            focusedBorder: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(10),
//              // borderSide: BorderSide(color: Colors.red)
//              gapPadding: 10,
//            ),
//          ),
//        ),
//        SizedBox(height:getProportionateScreenHeight(15)),
//      ],
//     );
//   }
// }
