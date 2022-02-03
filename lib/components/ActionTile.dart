import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config.dart';

class ActionTile extends StatelessWidget {
  ActionTile({
    this.color,
    required this.image,
    required this.text,
    required this.onClick,
    Key? key,
  }) : super(key: key);
  Color? color;
  Image image;
  String text;
  VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return Column(
        children:[
          GestureDetector(
            onTap: onClick,
            child: Container(
                height: getProportionateScreenHeight(63),
                width: getProportionateScreenWidth(55),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 5), // changes position of shadow,higher 5 less shadow
                      ),
                    ],
                    color: color
                ),
                child: image
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(5),),

          Text(text,style: GoogleFonts.titilliumWeb(
            textStyle: TextStyle(
                color: Color(0xFF0D1F3C), fontSize: 16.0, fontWeight: FontWeight.w400),
          ),)
        ]
    );
  }
}