import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/spray.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../screens/dashboard.dart';

class PageTitle extends StatelessWidget {
  PageTitle({this.pageTitle});

  final pageTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 70.0, 70.0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BackButton(
            color: Color(0xff3F51B5),
            onPressed: () {
             Navigator.maybePop(context);
            },
          ),
          Center(
            child: Text(
              '$pageTitle',
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      color: Color(0xff3F51B5),
                      fontSize: 36.0,
                      fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }
}
