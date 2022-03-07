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
  bool auto=false;
  int i=0;


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
      Text('Swipe Image up to Spray',
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
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              print('Swippey Up');

              setState(() {
                _isInitialValue = !_isInitialValue;
                Timer(Duration(milliseconds: 200), () {
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
           //   padding: EdgeInsets.fromLTRB(0),
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
              '\$$amt',
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      color: Color(0xff243656),
                      fontSize: 36.0,
                      fontWeight: FontWeight.w700)),
            ),
            GestureDetector(
              onTap: (){
                Fluttertoast.showToast(
                    msg: auto? "Auto-Spray activated 🤑😀" : "Auto-Spray is deactivated",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 2,
                    backgroundColor: auto!=true ? Colors.green : Colors.red ,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
               setState(() {
                 auto=!auto;
                 print('auto is: $auto');
               });
              // while(i<widget.times){
              //    Timer(Duration(seconds: 2),(){
              //      setState(() {
              //        print('Deducted: ${widget.times} times');
              //        amt-=result;
              //       // print(amt);
              //      });
              //    });
              //  }
             //  while(auto){
                 // Timer(Duration(milliseconds: 6000), (){
                 //   print('Printed to trigger Spray');
                 //   setState(() {
                 //     _isInitialValue = !_isInitialValue;
                 //     Timer(Duration(milliseconds: 200), () {
                 //       setState(() {
                 //         amt-=result;
                 //         _isInitialValue = !_isInitialValue;
                 //         print("Yeah, this line is printed after Spray succeeds");
                 //       });
                 //     });
                 //   });
                 // });
                // Timer(Duration(
                //   seconds: 3
                // ),(){
                //    print('Printing after 3 seconds');
                // });
             //  }
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
      )
    ]));
  }
}
