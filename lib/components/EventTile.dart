
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';
import '../models/all_event_model.dart';
import '../size_config.dart';

class EventTile extends StatelessWidget {
  // EventTile({required this.eventName, required this.eventCode,required this.startTime,required this.description,required this.participantCount});
  EventTile({required this.event});
  AllEvents? event;
  // final String eventName,eventCode, startTime, description, participantCount;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .06),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              color: Color(0xFFF8F7FC),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.asset('assets/image1.png', scale: 3.5,
                        ),
                  ),
                ),
                SizedBox(
                  width: Get.width * .7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(event!.name.toString(),
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: Color(0xff464646),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700)),),
                          Row(
                            children: [
                              Icon(Icons.person_outline_outlined,color: primaryColor, size: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 6.0, right: 8.0),
                                child: Text(event!.participantCount.toString(),style:
                                  TextStyle(
                                    color: Color(0xFF38A3A5)
                                  ),),
                              ),
                            ],
                          )],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: SizedBox(
                          width: Get.width * .6,
                          child: Text(event!.owner!.fullname.toString(),
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: Color(0xFF38A3A5),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400)),),
                        ),
                      ),
                      SizedBox(
                        child: Text('Start Time: ${event!.startTime}',
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: primaryColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold)),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(event!.eventCode.toString(),
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      color: Color(0xFF3F51B5),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700)),),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFF38A3A5),
                                      borderRadius: BorderRadius.circular(30.0)
                                  ),
                             //     margin: EdgeInsets.only(left: getProportionateScreenWidth(110.0)),
                                  padding: EdgeInsets.symmetric(vertical: 8.0,
                                      horizontal: 25.0),
                                  child: Text('Join',
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700)),),
                                ),
                              )

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(15.0)),
        ],
      ),
    );
  }
}
