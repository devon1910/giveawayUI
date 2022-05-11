import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giveawayui/screens/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadDash extends StatefulWidget {
  static String routeName = "/loadDash";
//   String token;
//   LoadDash({required this.token});

  @override
  _LoadDashState createState() => _LoadDashState();
}

class _LoadDashState extends State<LoadDash> {
  // String transUrl = "https://spray-dev.herokuapp.com/api/transactions/me?limit=5&page=1";
  // String userUrl="https://spray-dev.herokuapp.com/api/users/";
  // String userEventsUrl="https://spray-dev.herokuapp.com/api/events/me";
  // String allEventsUrl="https://spray-dev.herokuapp.com/api/events/?limit=5&page=1";



  // late List<dynamic> data;

  // Future<dynamic> getUser() async {
  //   // GETTING USER
  //   final response = await http
  //       .get(Uri.parse(userUrl), headers: {
  //     'x-auth-token': widget.token,
  //   });
  //   if(response.statusCode==200) {
  //     final responseJson = jsonDecode(response.body);
  //     return responseJson;
  //   }
  // }

  // Future<dynamic> getTrans() async {
  //   //GETTING TRANSACTIONS
  //   var responseT = await http.get(Uri.parse(transUrl), headers: {
  //     'Accept': 'application/json',
  //     'x-auth-token': widget.token,
  //   });

  //   return responseT;
  // }
  // Future<dynamic> getUserEvent() async {
  //   //GETTING EVENTS
  //   final responseE = await http.get(
  //       Uri.parse(userEventsUrl),
  //       headers: {
  //         'x-auth-token': widget.token,
  //       });
  //   return responseE;
  // }
  // Future<dynamic> getAllEvents() async {
  //   //GETTING EVENTS
  //   final responseE = await http.get(
  //       Uri.parse(allEventsUrl));
  //   print(responseE);
  //   return responseE;
  // }

  // void getData()async{
  //   var user=await getUser();
  //   var userEvent= await getUserEvent();
  //   var trans= await getTrans();
  //   var allEvents= await getAllEvents();

  //   Navigator.of(context).push(
  //       MaterialPageRoute(
  //           builder:(context)=> Dashboard(
  //               token: widget.token,
  //               user:  user,
  //               userEvent: userEvent,
  //               allEvents: allEvents,
  //               trans: trans)));
  // }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDualRing(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}
