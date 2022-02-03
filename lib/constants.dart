import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final primaryGiveawayStyle = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: Color(0xff3F51B5), fontSize: 80.0, fontWeight: FontWeight.w800));

final secondaryGiveawayStyle = GoogleFonts.nunito(
    textStyle: TextStyle(
        color: Color(0xff3F51B5), fontSize: 36.0, fontWeight: FontWeight.w800));
final subtextStyle = GoogleFonts.titilliumWeb(
    textStyle: TextStyle(
        color: Color(0xFF0D1F3C), fontSize: 25.0, fontWeight: FontWeight.w700));

final subtextContentStyle = GoogleFonts.titilliumWeb(
    textStyle: TextStyle(
        color: Color(0xFF0D1F3C), fontSize: 20.0, fontWeight: FontWeight.w400),
);

final nextButtonStyle = GoogleFonts.titilliumWeb(
  textStyle: TextStyle(
      color: Color(0xFF3F51B5), fontSize: 20.0, fontWeight: FontWeight.w600),
);
final circleStyle= LinearGradient(
    colors: [
      Color(0xFFFD749B),
      Color(0xFF281AC8),
    ],
    stops: [0.0, 1.0],
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
    tileMode: TileMode.repeated
);
