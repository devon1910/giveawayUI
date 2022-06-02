
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/UserModel.dart';
import 'app_settings.dart';

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

Map<String, dynamic> appSettings = {};
Map<String, dynamic> defaultSettings = {
  "onBoarding": true,
  "isLogin": false,
  'hasEvent': false,
  'lastEventTime': 0, 
};

final eventType = <String>[
    'Event Type', 'Wedding', 'Birthday' 'Party', 'Concert', 'Naming Celebration', 'Religious Event', 'Others'
  ];

late UserModel userModel;
//to update or read the get_storage data
late AppSettings generalFunction;
//to initialize the get storage
late GetStorage appStorage;
late GetStorage userStorage;


