import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giveawayui/screens/spray_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../components/loadDash.dart';
import '../http_exception.dart';
import '../size_config.dart';

class VerifyPin extends StatefulWidget {
  static String routeName = "/verifyPin";
  const VerifyPin(
      {required this.token,
      required this.ecode,
      required this.amount,
      required this.times});

  final String token;
  final String? ecode;
  final double amount;
  final double times;

  @override
  _VerifyPinState createState() => _VerifyPinState();
}

class _VerifyPinState extends State<VerifyPin> {
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  String confirmpin = "";
  String message = "";
  String savedPin = "";
  void getPin() async {
    final response = await http
        .get(Uri.parse('https://spray-dev.herokuapp.com/api/users/'), headers: {
      'x-auth-token': widget.token,
    });
    if (response.statusCode != 200) {
      throw HTTPException(response.statusCode, "Unable to fetch data...");
    }
    final responseJson = jsonDecode(response.body);
    print(responseJson['data']['pin']);
    print('CONFIRM PIN: ' +
        confirmpin +
        'LENGTH :' +
        confirmpin.length.toString());
    setState(() {
      savedPin = responseJson['data']['pin'];
    });

    checkPin();
    print(responseJson);
  }

  void checkPin() async {
    print('Before comparison-confirm = ' + confirmpin);
    print('Before Comparison-saved = ' + savedPin);
    if (savedPin != confirmpin) {
      Alert(
        useRootNavigator: false,
        context: context,
        type: AlertType.error,
        desc: "Invalid Pin!",
        buttons: [
          DialogButton(
            child: Text(
              "Try Again",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () =>  pushNewScreenWithRouteSettings(
              context,
              settings: RouteSettings(name: VerifyPin.routeName),
              screen: VerifyPin(
                  token: widget.token,
                  ecode: widget.ecode,
                  amount: widget.amount,
                  times: widget.times),
              withNavBar: true,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            ),
            width: 120,
          )
        ],
      ).show();
      confirmpin="";
      //Keyyy Take Note


    } else {
      joinEvent();
    }
  }
  void joinEvent() async{
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: Text("Loading..."),
      duration: Duration(milliseconds: 8000), ), );
    String joinEventUrl= "https://spray-dev.herokuapp.com/api/events/?action=join&event_code=${widget.ecode}";
    var body = {"sprayAmount": widget.amount};
    var response = await http.put(Uri.parse(joinEventUrl),
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
          "x-auth-token": widget.token
        });
    print(response.body);
    if(response.statusCode==200){
      Fluttertoast.showToast(
          msg: "Successfully joined Event 🤑",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      pushNewScreenWithRouteSettings(
        context,
        settings: RouteSettings(name: SprayScreen.routeName),
        screen: SprayScreen(
        ),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    }
    else{
      Fluttertoast.showToast(
          msg: "Can't Join Event at this time",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 6,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoadDash()));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(40, 80, 40, 20),
        //width: double.infinity,
        child: Column(children: [
          Text(
            'Confirm Pin',
            style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800)),
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Text("Please enter your PIN to proceed",
              style: GoogleFonts.titilliumWeb(
                  textStyle: TextStyle(
                      color: Color(0xff485068),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400)),
              textAlign: TextAlign.center),
          SizedBox(height: getProportionateScreenHeight(100.0)),
          Form(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                SizedBox(
                  width: getProportionateScreenWidth(50),
                  child: TextFormField(
                    autofocus: true,
                    onChanged: (value) {
                      confirmpin += value;
                      nextField(value, pin2FocusNode);
                    },
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenWidth(15)),
                      filled: true,
                      fillColor: Color(0xFFFFFF),
                      enabledBorder: OutlineInputBorder(
                          // borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      // focusedBorder:
                    ),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(50),
                  child: TextFormField(
                    focusNode: pin2FocusNode,
                    onChanged: (value) {
                      confirmpin += value;
                      nextField(value, pin3FocusNode);
                    },
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenWidth(15)),
                      filled: true,
                      fillColor: Color(0xFFFFFF),
                      enabledBorder: OutlineInputBorder(
                          // borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          //  borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      // focusedBorder:
                    ),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(50),
                  child: TextFormField(
                    focusNode: pin3FocusNode,
                    onChanged: (value) {
                      confirmpin += value;
                      nextField(value, pin4FocusNode);
                    },
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenWidth(15)),
                      filled: true,
                      fillColor: Color(0xFFFFFF),
                      enabledBorder: OutlineInputBorder(
                          // borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          //  borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      // focusedBorder:
                    ),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(50),
                  child: TextFormField(
                    focusNode: pin4FocusNode,
                    onChanged: (value) {
                      confirmpin += value;
                      pin4FocusNode.unfocus();
                      getPin();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Processing data"),
                          duration: Duration(milliseconds: 4000),
                        ),
                      );
                    },
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenWidth(15)),
                      filled: true,
                      fillColor: Color(0xFFFFFF),
                      enabledBorder: OutlineInputBorder(
                          // borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          //  borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      // focusedBorder:
                    ),
                  ),
                )
              ])),
        ]),
      ),
    );
  }
}
