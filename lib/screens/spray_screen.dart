import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/swipe.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../size_config.dart';
import '../swipedetector.dart';

class SprayScreen extends StatefulWidget {

  SprayScreen({required this.token,
    required this.ecode,
    required this.amount,
    required this.times});

  final String token;
  final String? ecode;
  final  amount;
  final  times;
  static String routeName = "/spray_screen";
  @override
  _SprayScreen createState() => _SprayScreen();

}


class _SprayScreen extends State<SprayScreen> {

  bool _isInitialValue = true;//checks height of swipe
  dynamic result;
  dynamic amt;

  // void _displaySuccessMotionToast() {
  //   MotionToast.success(
  //     title: Text(
  //       'You sprayed \$$result',
  //       style: TextStyle(fontWeight: FontWeight.bold),
  //     ),
  //     description: Text(
  //       '',
  //       style: TextStyle(fontSize: 12),
  //     ),
  //     animationType: ANIMATION.fromTop,
  //     position: MOTION_TOAST_POSITION.top,
  //     width: 300,
  //     animationDuration: Duration(milliseconds: 1500),
  //     onClose: (){
  //       return this.context;
  //     }
  //
  //   ).show(context);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amt=widget.amount;
    result=(amt)/(widget.times);
    print(widget.times);
    print(result);
    print(amt);
    //
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        margin: EdgeInsets.only(top: 45.0),
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
      Text('Swipe up to Spray',
          style: GoogleFonts.nunito(
              textStyle: TextStyle(
                  color: Color(0xff243656),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400))),
      SizedBox(height: getProportionateScreenHeight(70)),
          SwipeDetector(
            onSwipeUp: () {
              Fluttertoast.showToast(
                  msg: "You sprayed \$$result",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              print('Swippey Up');

              setState(() {
                _isInitialValue = !_isInitialValue;
                Timer(Duration(milliseconds: 300), () {
                  setState(() {
                    amt-=result;
                    _isInitialValue = !_isInitialValue;
                    print("Yeah, this line is printed after 2 seconds");
                  });
                });
              });
            },
        onSwipeDown: () {
              print('Wipe down');
        },
        child: Center(
            child: AnimatedContainer(
              height: _isInitialValue ?
              getProportionateScreenHeight(300)
                  :getProportionateScreenHeight(220),
              duration: const Duration(milliseconds: 200),
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
      SizedBox(height: getProportionateScreenHeight(50)),
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
              '\$$amt',
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      color: Color(0xff243656),
                      fontSize: 36.0,
                      fontWeight: FontWeight.w700)),
            ),
            Row(
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
            )
          ],
        ),
      )
    ]));
  }
}
