import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giveawayui/components/Scan.dart';
import 'package:giveawayui/screens/Transactions.dart';
import 'package:giveawayui/screens/all_events.dart';
import 'package:giveawayui/screens/create_event.dart';
import 'package:giveawayui/screens/dashboard.dart';
import 'package:giveawayui/screens/deposit.dart';
import 'package:giveawayui/screens/event_code.dart';
import 'package:giveawayui/screens/receive.dart';
import 'package:giveawayui/screens/send.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../http_exception.dart';
import '../size_config.dart';
import 'ActionListTile.dart';
import 'ActionTile.dart';
import 'loadDash.dart';


class Spray extends StatefulWidget {
  const Spray({required this.token,
    required this.trans,
    required this.user,
    required this.userEvent,
    required this.allEvents});
  final  trans,user,userEvent,allEvents;
  final String token;
  @override
  _SprayState createState() => _SprayState();
}

class _SprayState extends State<Spray> {
  bool isTran = false; //checks if Transaction exists
  dynamic amount;
  int virtualAmount=0;
  String eventStatus = "";
  String username = "";
  String ecode="";
  bool isActive=false;
  int transLength=0;
  String transType="";
  int subColor=0xFF006400;
  String img="assets/arrow-down-right-circle.png";
  var transData,data;
  void endEvent() async{
    String endEventUrl="https://spray-dev.herokuapp.com/api/events"
        "/status?event_code=$ecode&event_status=COMPLETED";
    var response = await http.post(
        Uri.parse(endEventUrl),
        headers: {
          "Content-Type": "application/json",
          "x-auth-token": widget.token
        });
    //var responseJson = jsonDecode(response.body);
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: Text("Loading..."),
      duration: Duration(milliseconds: 4000), ), );
    if(response.statusCode == 500){
      Alert(
        useRootNavigator: false,
        context: context,
        title: "Event Completed!",
        //desc: "",
        image: Image.asset(
            "assets/finalcheck.png",
            color: Colors.green),
        buttons: [
          DialogButton(
            color: Colors.blue,
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            onPressed: () {
              pushNewScreen(
                  context,
                  //  settings: RouteSettings(name: CreateEvent.routeName),
                  screen: LoadDash(
                       token: widget.token,),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino);
            },
            width: 120,
          )
        ],
      ).show();
    }else{
      Alert(
        useRootNavigator: false,
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: "Couldn't end Event. Try again",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      throw HTTPException(response.statusCode, "Unable to end event...");
    }
  }
  void loadDialog(){
    Alert(
      image: Image.asset('assets/Group.png'),
      useRootNavigator: false,
      context: context,
      // type: AlertType.info,
      //  title: "RFLUTTER ALERT",
      desc: "How do you wanna spray!?",
      buttons: [
        DialogButton(
          padding: EdgeInsets.all(10),
          child: Text(
            "Scan QR code",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: getProportionateScreenWidth(16)),
          ),
          onPressed: () {
            pushNewScreenWithRouteSettings(context,
                settings: RouteSettings(name: CreateEvent.routeName),
                screen: Send(token: widget.token),
                withNavBar: true,
                pageTransitionAnimation:
                PageTransitionAnimation.cupertino);
          },
          color: Colors.black,
        ),
        DialogButton(
          child: Text(
            "Enter Event code",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: getProportionateScreenWidth(14)),
          ),
          onPressed: () {
            pushNewScreen(context,
                //  settings: RouteSettings(name: EventCode.routeName),
                screen: EventCode(
                    token: widget.token,
                    allEvents: widget.allEvents),
                withNavBar: true,
                pageTransitionAnimation:
                PageTransitionAnimation.cupertino);
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
  void updateActionTile(){
    if(transType=="SEND"){
      subColor=0xFFDC143C;
      img="assets/Bitcoin.png";

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      setState(() {
       // virtualAmount=widget.user['data']['amount'];
        amount=widget.user['data']['amount'];
      //  amount = virtualAmount.toDouble();
        username = widget.user['data']['username'];
        if(widget.userEvent.statusCode == 200) {
          final responseEJson = json.decode(widget.userEvent.body);
          //converting data from data parameter to List Then to map
          //to access its Length
          List dataLength = responseEJson['data'];
          Map eventsMap = dataLength.asMap();
          int lastIndex=dataLength.length-1;
          eventStatus = eventsMap[lastIndex]['status'];
          print('event Status: '+eventStatus);
          ecode=  eventsMap[lastIndex]['event_code'];
          print('event code: '+ecode);
        }
        if (widget.trans.statusCode == 200) {
          var transactions = json.decode(widget.trans.body);
          Map<String, dynamic> transMap = transactions;
          List transList=transMap['data'];
          data = transMap['data'];
          transLength=transList.length;
          transType=data[transLength-1]['type'];
          isTran = true;
        }
        updateActionTile();
      });
    }


  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 240.0),
      color: Color(0xFFFFFFFF),
      child: Column(children: [
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
            gradient: LinearGradient(colors: [
              Color(0xFF3F51B5),
              Color(0xFF38A3A5),
              Color(0xFF38A3A5),
              Color(0xFF38A3A5)
            ]),
            //borderRadius:
          ),
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.only(top: 25.0),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/image1.png',
                      height: getProportionateScreenHeight(70)),
                  Container(
                    margin:
                        EdgeInsets.only(right: getProportionateScreenWidth(30)),
                    child: Column(
                        //  margin: EdgeInsets.only(right: 20),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello $username',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800))),
                          Text('Take a look at your\nwallet. Opor!',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w300))),
                        ]),
                  ),
                  // Icon(Icons.notifications_none_outlined,
                  //     size: 40.0, color: Colors.white)
                ],
              ),
            ),
            Container(
                // height: ,
                width: double.infinity,
                margin:
                    EdgeInsets.only(left: getProportionateScreenWidth(40.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\$${amount.toStringAsFixed(2)}',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 38.0,
                                fontWeight: FontWeight.w900))),
                    Text(
                      'Balance',
                      //textAlign: TextAlign.start,
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ))
          ]),
        ),
        //SizedBox(height: getProportionateScreenHeight(5.0),),
        Container(
          //   margin: EdgeInsets.only(bottom: 30.0),
          padding: EdgeInsets.fromLTRB(60, 20, 50, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActionTile(
                color: Color(0xffEDF1F9),
                image: Image.asset('assets/deposit.png'),
                text: 'Deposit',
                onClick: () {
                  pushNewScreen(
                      context,
                      //  settings: RouteSettings(name: CreateEvent.routeName),
                      screen: Deposit(
                          token: widget.token),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino);
                },
              ),
              ActionTile(
                color: Color(0xffF4F2F2),
                image: Image.asset('assets/send.png'),
                text: 'Send',
                onClick: () {
                  pushNewScreen(
                      context,
                      //  settings: RouteSettings(name: CreateEvent.routeName),
                      screen: Transfer(
                          token: widget.token),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino);
                },
              ),
              ActionTile(
                color: Color(0xFFD2E1FF),
                image: Image.asset('assets/receive.png'),
                text: 'Receive',
                onClick: () {
                  pushNewScreen(
                      context,
                      //  settings: RouteSettings(name: CreateEvent.routeName),
                      screen: Receive(
                        token: widget.token),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino);
                },
              ),
              ActionTile(
                color: Color(0xffEDF1F9),
                image: Image.asset('assets/redeem.png'),
                text: 'Redeem',
                onClick: () {
                },
              ),
            ],
          ),
        ),
        Container(
          //  color: Colors.red,
          margin: EdgeInsets.only(right: getProportionateScreenWidth(120)),
          child: Text(
            'Latest transaction',
            textAlign: TextAlign.start,
            style: GoogleFonts.titilliumWeb(
              textStyle: TextStyle(
                  color: Color(0xFF0D1F3C),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        if (isTran) ...[
          ActionListTile(
              img: img,
              heading: '${data[0]['transaction_amount']} chi',
              subheading: '$transType',
              subHeadColor: subColor,
              message: '${data[0]['payment_method']}',
              date: '${data[0]['transaction_date']}',
              color: 0xFFEDF1F9),
          ActionListTile(
              img: img,
              heading: '${data[1]['transaction_amount']} chi',
              subheading: '$transType',
              subHeadColor: subColor,
              message: '${data[1]['payment_method']}',
              date: '${data[1]['transaction_date']}',
              color: 0xFFEDF1F9),
          SizedBox(height: getProportionateScreenHeight(15)),
          GestureDetector(
            onTap: () {
              pushNewScreenWithRouteSettings(
                context,
                settings: RouteSettings(name: Transactions.routeName),
                screen: Transactions(
                  trans:widget.trans
                ),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Text('See all Transactions',
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: Color(0xFF3F51B5),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600))),
          ),
        ] else ...[
          SizedBox(
            height: getProportionateScreenHeight(40),
          ),
          Image.asset('assets/Mask.png', height: 50.0, color: Colors.grey),
          SizedBox(height: getProportionateScreenHeight(50)),
          Container(
            //margin: EdgeInsets.fromLTRB(0, 0, 150, 0),
            child: Center(
              child: Text('No Transactions',
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          color: Color(0xFF3F51B5),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600))),
            ),
          ),
        ],
        SizedBox(height:getProportionateScreenHeight(40)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                if(eventStatus=="ACTIVE")
                  {
                    endEvent();
                  }else {
                  pushNewScreen(
                      context,
                      //  settings: RouteSettings(name: CreateEvent.routeName),
                      screen: CreateEvent(widget.token),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino);

                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                margin: EdgeInsets.only(left: getProportionateScreenWidth(20)),
                decoration: BoxDecoration(
                    boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text(eventStatus=="ACTIVE" ? "End Event" :  "Create Event",
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: Color(0xFF38A3A5),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600))),
              ),
            ),
            GestureDetector(
              onTap: (){
                loadDialog();
              },
              child: Container(
                margin: EdgeInsets.only(left: getProportionateScreenWidth(10)),
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                decoration: BoxDecoration(
                  color: Color(0xFF3F51B5),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Text('Join Event',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600))),
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
      ]),
    );
  }
}
