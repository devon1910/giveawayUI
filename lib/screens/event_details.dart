import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../colors.dart';
import '../constants.dart';
import '../widgets.dart';
import '/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:social_share/social_share.dart';

import 'spray_screen.dart';

class EventDetails extends StatefulWidget {
  static String routeName = "/eventDetails";

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  
  late Map<String, dynamic> _eventDetail;
  @override
  void initState() {
    super.initState();
    _eventDetail = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    print(appSettings);
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: getProportionateScreenHeight(50.0)),
            child: Center(
              child: Text(
                'Event Details',
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: Color(0xff3F51B5),
                        fontSize: 44.0,
                        fontWeight: FontWeight.w800)),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30.0)),
          Container(
            // margin: EdgeInsets.only(right: getProportionateScreenWidth(150.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Event Name: ',
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400))),
                    Text('${_eventDetail["message"].toString().split(',')[0]}',
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: grey,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Event ID: ',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400))),
                    Text('${_eventDetail["event_code"]}',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: grey,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30.0)),
          Center(
            child: Text('QR CODE',
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: Color(0xff3F51B5),
                        fontSize: 26.0,
                        fontWeight: FontWeight.w700))),
          ),
          SizedBox(height: getProportionateScreenHeight(20.0)),
          QrImage(
            data: '${_eventDetail["event_code"]}',
            size: 200,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: getProportionateScreenHeight(20.0)),
          Center(
            child: Text('${_eventDetail["event_code"]}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: getProportionateScreenHeight(30.0)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text: '${_eventDetail["event_code"]}'));
                        },
                        icon: Icon(
                          Icons.copy,
                          color: primaryColor,
                        )),
                    Text(
                      'Copy',
                      style: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ],
                ),
                Container(
                  color: grey,
                  width: 2.0,
                  child: Divider(
                    height: 35.0,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        SocialShare.shareWhatsapp("Hello World");
                      },
                      icon: Icon(
                        Icons.ios_share_outlined,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Share',
                      style: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * .1),
            height: 50,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => primaryColor)),
                onPressed: () => Get.offAndToNamed(SprayScreen.routeName),
                child: Center(
                    child: Text(
                  'Goto Event',
                  style: TextStyle(fontSize: 18, wordSpacing: 2),
                ))),
          ),
        ],
      ),
    );
  }
}
