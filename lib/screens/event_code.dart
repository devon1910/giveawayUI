import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:giveawayui/components/DefaultButton.dart';
import 'package:giveawayui/screens/spray_amount.dart';
import 'package:giveawayui/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../components/page_title.dart';

class EventCode extends StatefulWidget {
  static String routeName="/eventCode";
  final String token;
  final allEvents;

  const EventCode({required this.token,required this.allEvents});

  @override
  _EventCodeState createState() => _EventCodeState();
}

class _EventCodeState extends State<EventCode> {
  String eventCode="";
  int eventsLength=0;
  Map eventsMap={};
  void verifyEventCode(){
    print(eventsMap);
    if(eventCode.isNotEmpty){
     for(int i=0;i<eventsLength;i++) {
       if (eventCode == eventsMap[i]['event_code'] &&
           eventsMap[i]['status'] == 'ACTIVE') {
         pushNewScreen(context,
           //  settings: RouteSettings(name: SprayAmount.routeName),
           screen: SprayAmount(
             ecode: eventCode,
             token: widget.token,
           ),
           withNavBar: true,
           pageTransitionAnimation: PageTransitionAnimation.cupertino,
         );
         return;
       }
     }
         Alert(
           useRootNavigator: false,
           context: context,
           type: AlertType.error,
           title: "ERROR",
           desc: "No ACTIVE Event with code: $eventCode",
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
    }else{
      Alert(
        useRootNavigator: false,
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: "Enter a valid Event Code.",
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
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.allEvents.statusCode == 200) {
      final responseEJson = json.decode(widget.allEvents.body);
      //converting data from data parameter to List Then to map
      //to access its Length
      print(responseEJson);
      List events = responseEJson['data'];
      eventsMap = events.asMap();
      eventsLength=events.length;
    }
  }
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
              children: [
               PageTitle(pageTitle: 'Event Code'),
                SizedBox(height: getProportionateScreenHeight(20.0)),
                Text('Event Event Code',
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400))),
                SizedBox(height:getProportionateScreenHeight(10)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    onChanged: (value){
                      eventCode=value;
                    },
                    autofocus: true,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xff243656), fontSize: 30.0, fontWeight: FontWeight.w700)),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      //  fillColor: Colors.grey,
                      //   filled: true,
                    //  hintText: 'Sarah\'s Wedding',
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
                SizedBox(height:getProportionateScreenHeight(70)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: DefaultButton(text: 'Next',
                      press: (){
                    print(eventCode);
                    verifyEventCode();

                      }
                  ),
                )
              ] ),
        )
    );
  }
}


