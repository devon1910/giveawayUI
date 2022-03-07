
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/DefaultButton.dart';
import 'package:giveawayui/screens/event_details.dart';
import 'package:giveawayui/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

import '../http_exception.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent(this.token);
  final String token;
  static String routeName="/createEvent";
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();
  String eventName="";
  String code="";
  String createEventUrl ="https://spray-dev.herokuapp.com/api/events/";

  void newEvent() async {
    //CREATING EVENT NAME
    var body = {
      "name": eventName
    };
    var response = await http.post(
        Uri.parse(createEventUrl),
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
          "x-auth-token": widget.token
        });
    var responseJson = jsonDecode(response.body);
    if (response.statusCode != 201) {
      Alert(
        useRootNavigator: false,
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: "Couldn't create event. Try again",
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
      throw HTTPException(response.statusCode, "Unable to create event...");
    }
    else {
      print(responseJson);
      setState(() {
        code = responseJson['event_code'];
      });
      //CHANGING EVENT STATUS TO ACTIVE
      String eventStatusUrl = "https://spray-dev.herokuapp.com/api/events/"
          "status?event_code=$code&event_status=active";
      var body = {
        "name": eventName
      };
      var statusResponse = await http.post(
          Uri.parse(eventStatusUrl),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
            "x-auth-token": widget.token
          });
      if (statusResponse.statusCode != 200) {
        Alert(
          useRootNavigator: false,
          context: context,
          type: AlertType.error,
          title: "ERROR",
          desc: "Couldn't Change event status. Try again",
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
        throw HTTPException(response.statusCode, "Unable to create event...");
      }

      else {
        Alert(
          useRootNavigator: false,
          context: context,
          title: "Event created successfully.",
          //desc: "",
          image: Image.asset(
            "assets/finalcheck.png",
            color: Colors.blue,),
          buttons: [
            DialogButton(
              color: Colors.blue,
              child: Text(
                "View Event Details",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder:(context)=> EventDetails(
                          name: eventName,
                          code: code,
                          token: widget.token,
                       )));
              },
              width: 120,
            )
          ],
        ).show();
      }
    }
  }

  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Text('Create Event',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff3F51B5), fontSize: 36.0, fontWeight: FontWeight.w800)) ,),
                  ),
                ),
                // Center(
                //     child: Text('Enter the amount you want to send',
                //       style: GoogleFonts.nunito(
                //           textStyle: TextStyle(
                //               color: Color(0xff243656), fontSize: 20.0, fontWeight: FontWeight.w400)),)),
                SizedBox(height: getProportionateScreenHeight(20.0)),
                Text('Event Name',
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400))),
                SizedBox(height:getProportionateScreenHeight(10)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter some text';
                    //   }
                    //   return null;
                    // },
                    onChanged: (value){
                      eventName=value;
                      print(eventName);
                    },
                    autofocus: true,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xff243656), fontSize: 30.0, fontWeight: FontWeight.w700)),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      //  fillColor: Colors.grey,
                      //   filled: true,
                      hintText: 'Sarah\'s Wedding',
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff3F51B5)),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff3F51B5)),
                        gapPadding: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height:getProportionateScreenHeight(100)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: DefaultButton(text: 'Next',
                      press: (){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Creating event..."),
                          duration: Duration(milliseconds: 4000),),);
                        newEvent();
                      }
                  ),
                )
              ] ),
        )
    );
  }
}

