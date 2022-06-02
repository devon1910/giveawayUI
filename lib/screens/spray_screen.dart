import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors.dart';
import '../swipedetector.dart';
import '/components/loadDash.dart';
import '/screens/spray_amount.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../size_config.dart';

class SprayScreen extends StatefulWidget {
  static String routeName = "/spray_screen";
  @override
  _SprayScreen createState() => _SprayScreen();
}

class _SprayScreen extends State<SprayScreen> {
  final _ = Get.put(SprayScreenController());
  final controller = Get.find<SprayScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(children: [
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
          Obx(() => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Auto Spray'),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: controller.autoSpray.value ? green : red,
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        controller.autoSpray.value
                            ? 'Relax while we help you Spray'
                            : 'Swipe up the shaded area to Spray',
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: Color(0xff243656),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400))),
                  ),
                ],
              )),
          SizedBox(height: getProportionateScreenHeight(50)),
          Container(
            color: black.withOpacity(.02),
            child: SwipeDetector(
              onSwipeUp: () {},
              onSwipeDown: () {
                print('Wipe down');
              },
              child: Center(
                  child: AnimatedContainer(
                //   padding: EdgeInsets.fromLTRB(0),
                height: true //_isInitialValue //TODO
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
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(40.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'change',
                  // '\$${totalAmount.toStringAsFixed(2)}', //TODO
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          color: Color(0xff243656),
                          fontSize: 40.0,
                          fontWeight: FontWeight.w700)),
                ),
                GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: controller.autoSpray.value
                            ? "Auto-Spray is deactivated"
                            : "Auto-Spray activated 🤑😀",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 2,
                        backgroundColor: controller.autoSpray.value
                            ? Colors.red
                            : Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    controller.autoSpray.toggle();
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Obx(() => controller.autoSpray.value
                              ? Image.asset(
                                  'assets/swipe_arr.png',
                                  height: getProportionateScreenHeight(25.0),
                                  color: Color(0xff3F51B5),
                                )
                              : Container()),
                          Image.asset(
                            'assets/swipe.png',
                            height: getProportionateScreenHeight(25.0),
                            color: Color(0xff3F51B5),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text("Auto Spray"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
                  // Icon(Icons.info), //TODO
          Container(
            margin: EdgeInsets.only(right: getProportionateScreenWidth(120)),
            child: Text(
              'sray',
              // '${noOfSpray.floor()} sprays remaining', //TODO
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
                // onTap: controller.leaveEvent,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(20)),
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
                      borderRadius: BorderRadius.circular(8)),
                  child: Text("Leave Event",
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: Color(0xFF38A3A5),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600))),
                ),
              ),
              GestureDetector(
                // onTap: controller.topUp,
                child: Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
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
        ]),
        SafeArea(
            child: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 12),
            child: Icon(Icons.arrow_back_ios, color: black),
          ),
        )),
      ],
    ));
  }
}

class SprayScreenController extends GetxController {
  RxBool autoSpray = false.obs;
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

  // onSwipeUpAction() async {
  //   if (sprayAmountD <= totalAmountD) {
  //     print('About to SPRAYYY::::');
  //     Fluttertoast.showToast(
  //         msg: "You sprayed \$${sprayAmount.toStringAsFixed(2)}",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.TOP,
  //         timeInSecForIosWeb: 2,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //     setState(() {
  //       _isInitialValue = !_isInitialValue;
  //       Timer(Duration(milliseconds: 300), () {
  //         setState(() {
  //           totalAmount -= sprayAmount;
  //           noOfSpray -= 1;
  //           _isInitialValue = !_isInitialValue;
  //           totalAmountToSpray += sprayAmount;
  //           sprayAmountD = double.parse(sprayAmount.toStringAsFixed(2));
  //           totalAmountD = double.parse(totalAmount.toStringAsFixed(2));
  //           print("totalAmount: $totalAmountD");
  //           print("Denomination: $sprayAmountD");
  //           print("number of sprrays: $noOfSpray");
  //           print("Total to SPray: $totalAmountToSpray");
  //           if (noOfSpray == 0) sprayNow();
  //         });
  //       });
  //     });
  //   }
  // }

  // void sprayNow() async {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text("Loading..."),
  //       duration: Duration(milliseconds: 8000),
  //     ),
  //   );

  //   if (totalAmountToSpray <= 0) {
  //     Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (context) => LoadDash()));
  //   } else {
  //     String sprayUrl =
  //         "https://spray-dev.herokuapp.com/api/events/spray?event_code=${'widget.ecode'}";
  //     var body = {
  //       "sprayAmount": totalAmountToSpray,
  //     };
  //     var response = await http.post(Uri.parse(sprayUrl),
  //         body: json.encode(body),
  //         headers: {
  //           "Content-Type": "application/json",
  //           "x-auth-token": 'widget.token'
  //         });
  //     print(response.body);

  //     if (response.statusCode != 200) {
  //       Alert(
  //         useRootNavigator: false,
  //         context: context,
  //         type: AlertType.error,
  //         desc: "Spray Unsuccessful",
  //         buttons: [
  //           DialogButton(
  //             child: Text(
  //               "OK",
  //               style: TextStyle(color: Colors.white, fontSize: 22),
  //             ),
  //             onPressed: () => pushNewScreen(
  //               context,
  //               //  settings: RouteSettings(name: SprayAmount.routeName),
  //               screen: SprayAmount(
  //                 ecode: 'widget.ecode',
  //                 token: 'widget.token',
  //               ),
  //               withNavBar: true,
  //               pageTransitionAnimation: PageTransitionAnimation.cupertino,
  //             ),
  //             width: 120,
  //           )
  //         ],
  //       ).show();
  //     } else {
  //       Navigator.of(context)
  //           .push(MaterialPageRoute(builder: (context) => LoadDash()));
  //       Fluttertoast.showToast(
  //           msg: "You Sprayed $totalAmountToSpray chi 🤑",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.TOP,
  //           timeInSecForIosWeb: 7,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     }
  //   }
  // }

  // void leaveEvent() async {
  //   String leaveUrl =
  //       "https://spray-dev.herokuapp.com/api/events/?action=kick&event_code=${'widget.ecode'}";
  //   var response = await http.put(Uri.parse(leaveUrl), headers: {
  //     "Content-Type": "application/json",
  //     "x-auth-token": userModel.token!
  //   });
  //   if (response.statusCode != 200) {
  //     Alert(
  //       useRootNavigator: false,
  //       context: context,
  //       type: AlertType.error,
  //       desc: "Can't leave event at the moment",
  //       buttons: [
  //         DialogButton(
  //           child: Text(
  //             "OK",
  //             style: TextStyle(color: Colors.white, fontSize: 22),
  //           ),
  //           onPressed: () => Navigator.pop(context),
  //           width: 120,
  //         )
  //       ],
  //     ).show();
  //   } else {
  //     Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (context) => LoadDash()));
  //   }
  // }

  // void topUp() {
  //   sprayNow();
  //   pushNewScreen(
  //     context,
  //     //  settings: RouteSettings(name: SprayAmount.routeName),
  //     screen: SprayAmount(
  //       ecode: 'widget.ecode',
  //       token: userModel.token!,
  //     ),
  //     withNavBar: true,
  //     pageTransitionAnimation: PageTransitionAnimation.cupertino,
  //   );
  // }
}
