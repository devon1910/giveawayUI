import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:giveawayui/components/ActionTile.dart';
import 'package:giveawayui/screens/send.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../size_config.dart';

class Receive extends StatefulWidget {
  static String routeName="/receive";
  @override
  _ReceiveState createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {
  //final controller = TextEditingController();
  String text="";
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 200.0),
      color: Color(0xFFFFFFFF),
      child: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.only(bottomRight: Radius.circular(60)),
                  gradient:LinearGradient(
                      colors: [
                        Color(0xFF3F51B5),
                        Color(0xFF38A3A5),
                        Color(0xFF38A3A5),
                        Color(0xFF38A3A5)
                      ]
                  ),
                  //borderRadius:
                ),
                child: Column(
                    children:[
                      Container(
                        padding: EdgeInsets.all(20.0),
                        margin: EdgeInsets.only(top:15.0),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('assets/image1.png',
                                height: getProportionateScreenHeight(70)),
                            Container(
                              margin: EdgeInsets.only(right:40),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    Container(
                                      margin: EdgeInsets.only(right:20),
                                      child: Text('Hello Chief',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.nunito(
                                              decoration: TextDecoration.none,
                                              textStyle: TextStyle(
                                                  color: Color(0xffffffff), fontSize: 20.0, fontWeight: FontWeight.w800))),
                                    ),
                                    Text('Take a look at your\nwallet. Opor!',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.nunito(
                                            decoration: TextDecoration.none,
                                            textStyle: TextStyle(
                                                color: Color(0xffffffff), fontSize: 15.0, fontWeight: FontWeight.w300)) ),
                                  ] ),
                            ),

                            Icon(Icons.notifications_none_outlined,size: 40.0,color: Colors.white)
                          ],
                        ),

                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0,10.0,150.0,0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('\$ 272.30',
                                  textAlign: TextAlign.start,
                                  style:GoogleFonts.nunito(
                                      decoration: TextDecoration.none,
                                      textStyle: TextStyle(
                                          color: Color(0xffffffff), fontSize: 38.0, fontWeight: FontWeight.w900))),
                              Container(
                                margin: EdgeInsets.only(right:80),
                                child: Text('Balance',
                                  textAlign: TextAlign.start,
                                  style:GoogleFonts.nunito(
                                      decoration: TextDecoration.none,
                                      textStyle: TextStyle(
                                          color: Color(0xffffffff), fontSize: 16.0, fontWeight: FontWeight.w400)) ,),
                              )
                            ],
                          )
                      )]
                ),
              ),
              //SizedBox(height: getProportionateScreenHeight(5.0),),
              Card(
                elevation: 0,
                margin: EdgeInsets.fromLTRB(60, 20, 50, getProportionateScreenHeight(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionTile(
                      color: Color(0xffEDF1F9),
                      image: Image.asset('assets/deposit.png'),
                      text: 'Deposit',
                      onClick: (){

                      },
                    ),
                    ActionTile(
                      color: Color(0xffF4F2F2),
                      image: Image.asset('assets/send.png'),
                      text: 'Send',
                      onClick: (){
                        // pushNewScreenWithRouteSettings(
                        // //   context,
                        // //   settings: RouteSettings(name: Send.routeName),
                        // //   screen: Send(),
                        // //   withNavBar: true,
                        // //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        // // );

                      },
                    ),
                    ActionTile(
                      color: Color(0xFFD2E1FF),
                      image: Image.asset('assets/receive.png'),
                      text: 'Receive',
                      onClick: (){
                        pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(name: Receive.routeName),
                          screen: Receive(),
                          withNavBar: true,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                    ),
                    ActionTile(
                      color: Color(0xffEDF1F9),
                      image: Image.asset('assets/redeem.png'),
                      text: 'Redeem',
                      onClick: (){

                      },
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.fromLTRB(90.0, 0, 0, 0.0),
                elevation: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Receive',
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xff3F51B5), fontSize: 40.0, fontWeight: FontWeight.w800)),),
                    Icon(Icons.cancel,
                      size: 40.0,
                      color: Color(0xFF3F51B5),)
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
                          onPressed: () => setState(() {
                            })),

                        ),

                      ),
                  ),
//                      style: GoogleFonts.nunito(
//                          textStyle: TextStyle(
//                              color: Color(0xff000000), fontSize: 20.0, fontWeight: FontWeight.w400)),),
                  ])]),
      ),
      );
  }
}
