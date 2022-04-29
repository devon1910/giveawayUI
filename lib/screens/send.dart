import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/DefaultButton.dart';
import 'package:giveawayui/components/page_title.dart';
import 'package:giveawayui/screens/verify_send.dart';
import 'package:giveawayui/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';


import '../http_exception.dart';

class Transfer extends StatefulWidget {
  const Transfer({required this.token});
  final String token;

  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  String amount='',recipient='';

  void verifyUsername() async{
      final response = await http
          .get(Uri.parse('https://spray-dev.herokuapp.com/api/users/${recipient.capitalize()}'), headers: {
        'x-auth-token': widget.token,
      });
      if(response.statusCode==200) {
        pushNewScreen(
            context,
            screen: VerifySend(
                recipient: recipient,
                amount: amount,
                token: widget.token),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino);
      }
      else{
        Alert(
          useRootNavigator: false,
          context: context,
          type: AlertType.error,
          title: "ERROR",
          desc: "Username doesn't exist",
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
        throw HTTPException(response.statusCode, "Username doesn't exist...");
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
        //  key: _formKey,
          child: Column(
              children: [
                PageTitle(pageTitle: 'Send Money'),
                SizedBox(height: getProportionateScreenHeight(20.0)),
                Text('Amount',
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
                      amount=value;
                      //print(amount);
                    },
                    autofocus: true,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xff243656), fontSize: 30.0, fontWeight: FontWeight.w700)),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      //  fillColor: Colors.grey,
                      //   filled: true,
                    //  hintText: '',
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
                SizedBox(height: getProportionateScreenHeight(20.0)),
                Text('Recipient',
                    textAlign: TextAlign.left,
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
                      recipient=value;
                     // print(wallet);
                    },
                    autofocus: true,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xff243656), fontSize: 30.0, fontWeight: FontWeight.w700)),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      //  fillColor: Colors.grey,
                      //   filled: true,
                      //  hintText: '',
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
                SizedBox(height:getProportionateScreenHeight(40)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: DefaultButton(text: 'Done',
                      press: (){
                        verifyUsername();
                      }
                  ),
                )
              ] ),
        )
    );
  }
}
