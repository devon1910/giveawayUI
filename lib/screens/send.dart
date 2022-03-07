import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giveawayui/components/DefaultButton.dart';
import 'package:giveawayui/components/loadDash.dart';
import 'package:giveawayui/screens/dashboard.dart';
import 'package:giveawayui/size_config.dart';
import 'package:google_fonts/google_fonts.dart';

class Transfer extends StatefulWidget {
  const Transfer({required this.token});
  final String token;

  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  String amount='',wallet='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
        //  key: _formKey,
          child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Text('Send Money',
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
                      print(amount);
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
                Text('Wallet',
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
                      wallet=value;
                      print(wallet);
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Loading..."),
                          duration: Duration(milliseconds: 4000),),);
                        Fluttertoast.showToast(
                            msg: "You sent \$$amount to $wallet 🤑",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 4,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder:(context)=> LoadDash(token: widget.token)));

                      }
                  ),
                )
              ] ),
        )
    );
  }
}
