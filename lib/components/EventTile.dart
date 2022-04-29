import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config.dart';

class EventTile extends StatelessWidget {
  EventTile({required this.eventName, required this.eventCode});

  final String eventName,eventCode;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFF8F7FC),
              borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
               // margin: EdgeInsets.only(bottom: 30.0),
                child: Image.asset('assets/image1.png',
                    height: getProportionateScreenHeight(70)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(eventName,
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff464646),
                              fontSize: getProportionateScreenHeight(18),
                              fontWeight: FontWeight.w700)),),
                      Row(
                        children: [
                          Icon(Icons.person,color: Color(0xFF38A3A5)),
                          Text('234',style:
                            TextStyle(
                              color: Color(0xFF38A3A5)
                            ),),
                        ],
                      )],
                  ),
                  Container(
                    width: getProportionateScreenWidth(150),
                    child: Text('Moyo is getting married to devon today on the 23rd of '
                        'February.',
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xFF38A3A5),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400)),),
                  ),
                  Container(
                    width: getProportionateScreenWidth(210),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(eventCode,
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
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(15.0)),
      ],
    );
  }
}
