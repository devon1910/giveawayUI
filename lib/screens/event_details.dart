

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giveawayui/components/DefaultButton.dart';
import 'package:giveawayui/components/loadDash.dart';
import 'package:giveawayui/components/spray.dart';
import 'package:giveawayui/screens/dashboard.dart';
import 'package:giveawayui/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:social_share/social_share.dart';


class EventDetails extends StatefulWidget {
  static String routeName="/eventDetails";
  const EventDetails({required this.name,required this.code,required this.token});

 final String name,code,token;


  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(top:getProportionateScreenHeight(50.0)),
              child: Center(
                child: Text('Event Details',
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          color: Color(0xff3F51B5), fontSize: 44.0, fontWeight: FontWeight.w800)) ,),
              ),
            ),
          SizedBox(height:getProportionateScreenHeight(30.0)),
          Container(
           // margin: EdgeInsets.only(right: getProportionateScreenWidth(150.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Event Name : ${widget.name}',
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xff000000), fontSize: 16.0, fontWeight: FontWeight.w400))
                ),
                SizedBox(height:getProportionateScreenHeight(20.0)),
                Text(
                    'Event ID : ${widget.code}',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.nunito(

                        textStyle: TextStyle(
                            color: Color(0xff000000), fontSize: 16.0, fontWeight: FontWeight.w400))
                ),
              ],
            ),
          ),

          SizedBox(height:getProportionateScreenHeight(30.0)),
          Center(
            child: Text('QR CODE',
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: Color(0xff3F51B5), fontSize: 26.0, fontWeight: FontWeight.w700))
            ),
          ),
          SizedBox(height:getProportionateScreenHeight(20.0)),
          QrImage(
            data: '${widget.code}',
            size: 200,
            backgroundColor: Colors.white,
          ),
          SizedBox(height:getProportionateScreenHeight(20.0)),
          Center(
            child: Text('${widget.code}'),
          ),
          SizedBox(height:getProportionateScreenHeight(30.0)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceAround,
                //  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IconButton(
                      onPressed: (){
                       Clipboard.setData(ClipboardData(text: '${widget.code}'));
                        //SocialShare.copyToClipboard('${widget.code}');

                      },
                       icon: Icon(
                         Icons.copy
                       )
                    ),
                  Text('Copy'),

                ],),
                Container(
                  color: Color(0xff3F51B5),
                  width: 2.0,
                  child: Divider(height: 35.0,),
                ),
              Row(children: [
                IconButton(
                  onPressed: (){
                    SocialShare.shareWhatsapp("Hello World");
                  },
                  icon: Icon(
                    Icons.share
                  ),
                ),
                Text('Share')

             ],),

              ],

            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
         ElevatedButton(
             onPressed:  (){
               Navigator.of(context).push(
                   MaterialPageRoute(
                       builder:(context)=> LoadDash()));

             },
             child: Text('Home'))
        ],
      ),
    );
  }
}
