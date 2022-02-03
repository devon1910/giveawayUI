import 'package:flutter/material.dart';
import 'package:giveawayui/components/DefaultButton.dart';
import 'package:giveawayui/screens/spray_amount.dart';
import 'package:giveawayui/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class EventCode extends StatefulWidget {
  final String token;
  const EventCode({required this.token});

  @override
  _EventCodeState createState() => _EventCodeState();
}

class _EventCodeState extends State<EventCode> {
  String eventCode="";
  @override
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
                    child: Text('Event Code',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff3F51B5), fontSize: 36.0, fontWeight: FontWeight.w800)) ,),
                  ),
                ),
                // Center(

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
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter some text';
                    //   }
                    //   return null;
                    // },
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
                SizedBox(height:getProportionateScreenHeight(100)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: DefaultButton(text: 'Next',
                      press: (){
                    print(eventCode);
                        pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(name: SprayAmount.routeName),
                          screen: SprayAmount(
                            ecode: eventCode,
                            token: widget.token,
                          ),
                          withNavBar: true,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      }
                  ),
                )
              ] ),
        )
    );
  }
}


