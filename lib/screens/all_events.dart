import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:giveawayui/components/CategoryTile.dart';
import 'package:giveawayui/components/EventTile.dart';
import 'package:giveawayui/size_config.dart';
import 'package:google_fonts/google_fonts.dart';


class AllEvents extends StatefulWidget {
  AllEvents({required this.token,required this.allEvents});
  final  String token;
  final allEvents;

  @override
  _AllEventsState createState() => _AllEventsState();
}


class _AllEventsState extends State<AllEvents> {
  var data,eventsLength;
  List<String> themes= ['Party','Wedding','Concert','Birthdays'];
  List<int> themeColors=[0xFFF4F2F2, 0xFFE0E7CC, 0xFFF5F5F8, 0xFFEDF5F9];

  @override
  void initState() {
    // TODO: implement initState
    var allEvents = json.decode(widget.allEvents.body);
    Map<String, dynamic> eventsMap = allEvents;
    List eventsList = eventsMap['data'];
    data = eventsMap['data'];
    print(data);
    eventsLength = eventsList.length;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xFF3F51B5),
                  ),

                  Container(
                    width: getProportionateScreenWidth(200),
                    child: TextFormField(
                      onChanged: (value){
                      },
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff38A3A5),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400)),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xff38A3A5),),
                          fillColor: Color(0xFFEDF5F9),
                          filled: true,
                        hintText: 'Search...',
                        hintStyle: TextStyle(fontSize: 14.0, color: Color(0xff38A3A5)),
                        contentPadding: EdgeInsets.all(5),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                          gapPadding: 10,
                        ),
                      ),
                    ),
                  ),
                  Image.asset('assets/ex.png',
                    color: Color(0xFF3F51B5))
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(30.0),),
              Container(
                child: SizedBox(
                  height: 50,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                    children: [
                      CategoryTile(category: 'Party', margin: 20.0,color:0xFFF4F2F2),
                      CategoryTile(category: 'Wedding', margin: 20.0,color:0xFFE0E7CC),
                      CategoryTile(category: 'Concert', margin: 20.0,color: 0xFFF5F5F8),
                      CategoryTile(category: 'Birthday', margin: 0.0,color: 0xFFEDF5F9),
                    ]
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30.0),),
              Container(
                margin: EdgeInsets.only(right: getProportionateScreenWidth(180.0)),
                child: Text(
                  'Happening Now',
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30.0),),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return EventTile(
                          eventName: '${data[index]['name']}',
                          eventCode: '${data[index]['event_code']}');
                    },
                    itemCount: eventsLength),
              ),


            ],
          ),
        ),
      )
    );
  }
}
