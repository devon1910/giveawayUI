import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config.dart';

// ignore: must_be_immutable
class ActionListTile extends StatelessWidget {
  ActionListTile({
    Key? key,
    required this.heading,
    required this.subheading,
    required this.message,
    required this.date,
    required this.color,
    this.img
  }) : super(key: key);

  String? heading, subheading,message,date,img;
  int color;

  @override
  Widget build(BuildContext context) {
    return Container(
       // height: 200,
      decoration: BoxDecoration(
          color: Color(color),//
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      margin: EdgeInsets.fromLTRB(50,10,30,0),
      padding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
       width: getProportionateScreenWidth(270.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:[
            Image.asset(img!),//
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(heading!,//
                  style:GoogleFonts.nunito(
                      textStyle: TextStyle(
                          color: Color(0xFF0D1F3C), fontSize: 15.0, fontWeight: FontWeight.w600)),
                  textAlign: TextAlign.left,),
                Text(subheading!,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.titilliumWeb(//
                    textStyle: TextStyle(
                        color: Color(0xFF485068),
                        fontSize: 15.0, fontWeight: FontWeight.w400),
                  ),)
              ],
            ),
            Container(
            //  margin: EdgeInsets.only(left: 50.0),
              margin: EdgeInsets.only(left: getProportionateScreenWidth(70.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(message!,
                      style: GoogleFonts.titilliumWeb(
                        textStyle: TextStyle(
                            color: Color(0xFF3F51B5), fontSize: 15.0, fontWeight: FontWeight.w400),
                      ),
                     // textAlign: TextAlign.right
                  ),
                  Text(date!,
                    //textAlign: TextAlign.right,//
                    style: GoogleFonts.titilliumWeb(
                      textStyle: TextStyle(
                          color: Color(0xFF485068), fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),)
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(5.0))
          ]
      ),
    );
  }
}