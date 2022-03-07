import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/spray.dart';
import 'package:giveawayui/screens/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../http_exception.dart';

class LoadDash extends StatefulWidget {
  String token;
  LoadDash({required this.token});

  @override
  _LoadDashState createState() => _LoadDashState();
}

class _LoadDashState extends State<LoadDash> {
  String transUrl = "https://spray-dev.herokuapp.com/api/transactions/";
  late List<dynamic> data;

  Future<dynamic> getUser() async {
    // GETTING USER
    final response = await http
        .get(Uri.parse('https://spray-dev.herokuapp.com/api/users/'), headers: {
      'x-auth-token': widget.token,
    });
    final responseJson = jsonDecode(response.body);
    return responseJson;
  }

  Future<dynamic> getTrans() async {
    //GETTING TRANSACTIONS
    var responseT = await http.get(Uri.parse(transUrl), headers: {
      'Accept': 'application/json',
      'x-auth-token': widget.token,
    });

    return responseT;
  }
  Future<dynamic> getEvents() async {
    //GETTING EVENTS
    final responseE = await http.get(
        Uri.parse('https://spray-dev.herokuapp.com/api/events/'),
        headers: {
          'x-auth-token': widget.token,
        });
    final responseEJson = json.decode(responseE.body);
    //converting data from data parameter to List Then to map
    //to access its Length
    List dataLength = responseEJson['data'];
    Map mapDataLength = dataLength.asMap();
    return mapDataLength;
  }

  void getData()async{
    var user=await getUser();
    var events= await getEvents();
    var trans= await getTrans();

    Navigator.of(context).push(
        MaterialPageRoute(
            builder:(context)=> Dashboard(
                token: widget.token,
                user:  user,
                events: events,
                trans: trans)));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
