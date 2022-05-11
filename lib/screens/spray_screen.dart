import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/loadDash.dart';
import 'package:giveawayui/screens/spray_amount.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../size_config.dart';
import '../swipedetector.dart';

class SprayScreen extends StatefulWidget {
  SprayScreen(
      {required this.token,
      required this.ecode,
      required this.amount,
      required this.times});

  final String token;
  final String? ecode;
  final double amount;
  final double times;

  static String routeName = "/spray_screen";
  @override
  _SprayScreen createState() => _SprayScreen();
}

class _SprayScreen extends State<SprayScreen> {
  bool _isInitialValue = true; //checks height of swipe
  double sprayAmount = 0.0;
  double sprayAmountD = 0.0;
  double totalAmountD = 0.0;

  dynamic a;
  dynamic nOS;
  double totalAmount = 0;
  double noOfSpray = 0;
  double totalAmountToSpray = 0;
  bool auto = false;
  int i = 0;

  void sprayNow() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Loading..."),
        duration: Duration(milliseconds: 8000),
      ),
    );

    if (totalAmountToSpray <= 0) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoadDash()));
    } else {
      String sprayUrl =
          "https://spray-dev.herokuapp.com/api/events/spray?event_code=${widget.ecode}";
      var body = {
        "sprayAmount": totalAmountToSpray,
      };
      var response = await http.post(Uri.parse(sprayUrl),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
            "x-auth-token": widget.token
          });
      print(response.body);

      if (response.statusCode != 200) {
        Alert(
          useRootNavigator: false,
          context: context,
          type: AlertType.error,
          desc: "Spray Unsuccessful",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              onPressed: () => pushNewScreen(
                context,
                //  settings: RouteSettings(name: SprayAmount.routeName),
                screen: SprayAmount(
                  ecode: widget.ecode,
                  token: widget.token,
                ),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              ),
              width: 120,
            )
          ],
        ).show();
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoadDash()));
        Fluttertoast.showToast(
            msg: "You Sprayed $totalAmountToSpray chi 🤑",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 7,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  void leaveEvent() async {
    String leaveUrl =
        "https://spray-dev.herokuapp.com/api/events/?action=kick&event_code=${widget.ecode}";
    var response = await http.put(Uri.parse(leaveUrl), headers: {
      "Content-Type": "application/json",
      "x-auth-token": widget.token
    });
    if (response.statusCode != 200) {
      Alert(
        useRootNavigator: false,
        context: context,
        type: AlertType.error,
        desc: "Can't leave event at the moment",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoadDash()));
    }
  }

  void topUp() {
    sprayNow();
    pushNewScreen(
      context,
      //  settings: RouteSettings(name: SprayAmount.routeName),
      screen: SprayAmount(
        ecode: widget.ecode,
        token: widget.token,
      ),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    a = widget.amount.toStringAsFixed(2);
    nOS = widget.times.toStringAsFixed(2);
    totalAmount = double.parse(a);
    noOfSpray = double.parse(nOS);
    sprayAmount = (totalAmount) / (noOfSpray);
    print('Times: $noOfSpray');
    print('denomination: ${sprayAmount.toStringAsFixed(2)}');
    print('Amount to spray:  $totalAmount');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        margin: EdgeInsets.only(top: 60.0),
        child: Center(
          child: Text(
            'Spray',
            style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    color: Color(0xff3F51B5),
                    fontSize: 50.0,
                    fontWeight: FontWeight.w800)),
          ),
        ),
      ),
      SizedBox(height: getProportionateScreenHeight(15)),
      Text('Swipe Image up to Spray',
          style: GoogleFonts.nunito(
              textStyle: TextStyle(
                  color: Color(0xff243656),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400))),
      SizedBox(height: getProportionateScreenHeight(70)),
      SwipeDetector(
        onSwipeUp: () {
          if (sprayAmountD <= totalAmountD) {
            print('About to SPRAYYY::::');
            Fluttertoast.showToast(
                msg: "You sprayed \$${sprayAmount.toStringAsFixed(2)}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            setState(() {
              _isInitialValue = !_isInitialValue;
              Timer(Duration(milliseconds: 300), () {
                setState(() {
                  totalAmount -= sprayAmount;
                  noOfSpray -= 1;
                  _isInitialValue = !_isInitialValue;
                  totalAmountToSpray += sprayAmount;
                  sprayAmountD = double.parse(sprayAmount.toStringAsFixed(2));
                  totalAmountD = double.parse(totalAmount.toStringAsFixed(2));
                  print("totalAmount: $totalAmountD");
                  print("Denomination: $sprayAmountD");
                  print("number of sprrays: $noOfSpray");
                  print("Total to SPray: $totalAmountToSpray");
                  if (noOfSpray == 0) {
                    sprayNow();
                  }
                });
              });
            });
          }
        },
        onSwipeDown: () {
          print('Wipe down');
        },
        child: Center(
            child: AnimatedContainer(
          //   padding: EdgeInsets.fromLTRB(0),
          height: _isInitialValue
              ? getProportionateScreenHeight(300)
              : getProportionateScreenHeight(220),
          duration: const Duration(milliseconds: 400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/swipe_arr.png',
                height: getProportionateScreenHeight(300),
                color: Color(0xff3F51B5),
              ),
              Image.asset(
                'assets/swipe.png',
                height: getProportionateScreenHeight(300),
                color: Color(0xff3F51B5),
              ),
            ],
          ),
        )),
      ),
      //  SizedBox(height: getProportionateScreenHeight(50)),
      Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(160)),
        child: Text('Sprayyy Awayyy',
            style: GoogleFonts.titilliumWeb(
                textStyle: TextStyle(
                    color: Color(0xff3F51B5),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600))),
      ),
      SizedBox(height: getProportionateScreenHeight(20)),
      Container(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${totalAmount.toStringAsFixed(2)}',
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      color: Color(0xff243656),
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700)),
            ),
            GestureDetector(
              onTap: () {
                Fluttertoast.showToast(
                    msg: auto
                        ? "Auto-Spray activated 🤑😀"
                        : "Auto-Spray is deactivated",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 2,
                    backgroundColor: auto != true ? Colors.green : Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                setState(() {
                  auto = !auto;
                  print('auto is: $auto');
                });
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/swipe_arr.png',
                    height: getProportionateScreenHeight(25.0),
                    color: Color(0xff3F51B5),
                  ),
                  Image.asset(
                    'assets/swipe.png',
                    height: getProportionateScreenHeight(25.0),
                    color: Color(0xff3F51B5),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(120)),
        child: Text(
          '${noOfSpray.floor()} sprays remaining',
          style: GoogleFonts.nunito(
              textStyle: TextStyle(
                  color: Color(0xff243656),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700)),
        ),
      ),
      SizedBox(height: getProportionateScreenHeight(40)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              leaveEvent();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              margin: EdgeInsets.only(left: getProportionateScreenWidth(20)),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Text("Leave Event",
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: Color(0xFF38A3A5),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600))),
            ),
          ),
          GestureDetector(
            onTap: () {
              topUp();
            },
            child: Container(
              margin: EdgeInsets.only(left: getProportionateScreenWidth(10)),
              padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
              decoration: BoxDecoration(
                  color: Color(0xFF3F51B5),
                  borderRadius: BorderRadius.circular(8)),
              child: Text('Top Up',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600))),
            ),
          ),
        ],
      ),
    ]));
  }
}
