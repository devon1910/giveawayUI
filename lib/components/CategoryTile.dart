import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../size_config.dart';


class CategoryTile extends StatelessWidget {
  CategoryTile({required this.category,required this.margin,required this.color});

  final String category;
  final double margin;
  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
      margin: EdgeInsets.only(right: getProportionateScreenWidth(margin)),
      decoration: BoxDecoration(
          color: Color(color),//
          borderRadius: BorderRadius.all(Radius.circular(25))
      ),
      child: Center(
        child: Text(
          category,
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
              textStyle: TextStyle(
                  color: Color(0xff38A3A5),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
