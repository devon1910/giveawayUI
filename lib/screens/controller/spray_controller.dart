import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../models/transaction_model.dart';
import '/functions.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import '../../components/Scan.dart';
import '../../components/loadDash.dart';
import '../../http_exception.dart';
import '../../size_config.dart';
import '../create_event.dart';
import '../event_code.dart';

class HomeController extends GetxController {
  bool isTran = false; //checks if Transaction exists
  dynamic amount;
  int virtualAmount = 0;
  String eventStatus = "";
  String username = "";
  String ecode = "";
  bool isActive = false;
  int transLength = 0;
  String transType = "";
  int subColor = 0xFF006400;
  String img = "assets/arrow-down-right-circle.png";
  var transData, data;

  void endEvent() async {
    String endEventUrl = "https://spray-dev.herokuapp.com/api/events"
        "/status?event_code=$ecode&event_status=COMPLETED";
    var response = await http.post(Uri.parse(endEventUrl), headers: {
      "Content-Type": "application/json",
      "x-auth-token": "widget.token"
    });
    //var responseJson = jsonDecode(response.body);
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text("Loading..."),
        duration: Duration(milliseconds: 4000),
      ),
    );
    if (response.statusCode == 500) {
      Alert(
        useRootNavigator: false,
        context: Get.context!,
        title: "Event Completed!",
        //desc: "",
        image: Image.asset("assets/finalcheck.png", color: Colors.green),
        buttons: [
          DialogButton(
            color: Colors.blue,
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            onPressed: () {
              pushNewScreen(Get.context!,
                  //  settings: RouteSettings(name: CreateEvent.routeName),
                  screen: LoadDash(
                      //  token: "widget.token",
                      ),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino);
            },
            width: 120,
          )
        ],
      ).show();
    } else {
      Alert(
        useRootNavigator: false,
        context: Get.context!,
        type: AlertType.error,
        title: "ERROR",
        desc: "Couldn't end Event. Try again",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(Get.context!),
            width: 120,
          )
        ],
      ).show();
      throw HTTPException(response.statusCode, "Unable to end event...");
    }
  }

  void loadDialog() {
    Alert(
      image: Image.asset('assets/Group.png'),
      useRootNavigator: false,
      context: Get.context!,
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
            pushNewScreenWithRouteSettings(Get.context!,
                settings: RouteSettings(name: CreateEvent.routeName),
                screen: Send(token: "widget.token"),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino);
          },
          color: Colors.black,
        ),
        DialogButton(
          child: Text(
            "Enter Event code",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: getProportionateScreenWidth(14)),
          ),
          onPressed: () {
            pushNewScreen(Get.context!,
                //  settings: RouteSettings(name: EventCode.routeName),
                screen:
                    EventCode(token: "widget.token", allEvents: "allEvents"),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino);
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  void updateActionTile() {
    if (transType == "SEND") {
      subColor = 0xFFDC143C;
      img = "assets/Bitcoin.png";
    }
  }

  Future getAllTransactions({int length = 2, int page= 1}) async {
    try {
      var response = await httpGet(
          url:
              'https://spray-dev.herokuapp.com/api/transactions/me?limit=$length&page=$page',
          header: {'x-auth-token': userModel.token!});
      if(response['status'] == 200){
        TransactionModel? tModel = new TransactionModel.fromJson(response);
        if (tModel.data!.length > 0) {
          print(response);
          return {'status': response['status'], 'message': tModel.data};
        }
        
        return null;
      }
      
      return response;
    } catch (e) {
      print(e);
    }
  }
}
