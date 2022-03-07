import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:giveawayui/components/ActionTile.dart';
import 'package:giveawayui/components/loadDash.dart';
import 'package:giveawayui/screens/send.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:social_share/social_share.dart';

import '../size_config.dart';
import 'dashboard.dart';

class Receive extends StatefulWidget {
  static String routeName="/receive";
  final String token;
  const Receive({required this.token});
  @override
  _ReceiveState createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {
  //final controller = TextEditingController();
  bool isCreated=false;
  String text="";
  @override
  Widget build(BuildContext context) {
    return Container(
       //margin: EdgeInsets.only(top: getProportionateScreenHeight(100.0)),
      color: Color(0xFFFFFFFF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
             // margin: EdgeInsets.fromLTRB(getProportionateScreenWidth(90.0),getProportionateScreenWidth(90.0), 0, 0.0),
              elevation: 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Text('Receive',
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xff3F51B5), fontSize: getProportionateScreenWidth(40), fontWeight: FontWeight.w800)),),
                  ),
                  Center(
                    child: Text('Generate and Send QR code to Friends!',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff3F51B5), fontSize: getProportionateScreenWidth(16), fontWeight: FontWeight.w300)),),
                  ),

                ],
              ),
            ),
            Column(
              children: [
                //Image.asset('assets/Bitmap.png'),
                QrImage(
                    data: text,
                    size: 200,
                    backgroundColor: Colors.white,
                  ),

                if( isCreated)...[
                  SizedBox(height: getProportionateScreenHeight(30.0),),
                  Card(
                    elevation: 0,
                    child: Container(
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
                                    Clipboard.setData(ClipboardData(text: text));
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
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  ElevatedButton(
                    style: ButtonStyle(

                    ) ,
                      onPressed:  (){
                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                          content: Text("Loading..."),
                          duration: Duration(milliseconds: 5000), ), );
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder:(context)=> LoadDash(token: widget.token)));

                      },
                      child: Text('Home'))
                ] else...[
                  Card(
                    child: TextField(
                      onChanged: (value){
                        text=value;
                      },
                      //controller: controller,
                      style: TextStyle(
                          color: Color(0xff3F51B5),
                          fontWeight: FontWeight.w400,
                          fontSize: 20
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Data',
                        hintStyle: TextStyle(
                            color: Colors.grey
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.done),
                            onPressed: () =>
                                setState(() {
                              isCreated= true;
                            })),

                      ),

                    ),
                  ),
                ]

//                      style: GoogleFonts.nunito(
//                          textStyle: TextStyle(
//                              color: Color(0xff000000), fontSize: 20.0, fontWeight: FontWeight.w400)),),
                ])]),
      );
  }
}
