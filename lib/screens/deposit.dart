import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giveawayui/components/DefaultButton.dart';
import 'package:giveawayui/components/loadDash.dart';
import 'package:giveawayui/components/page_title.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import '../size_config.dart';

class Deposit extends StatefulWidget {
  const Deposit({required this.token});

  final String token;

  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  String dropdownValue = 'CHI';
 String amount='';
  void fundWallet() async{
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: Text("Loading..."),
      duration: Duration(milliseconds: 8000), ), );
    String fundUrl = "https://spray-dev.herokuapp.com/api/transactions/topup";
    var body = {
      "recipient": "receiver_username",
      "amount": amount,
      "currency": "chi"
    };
    var statusResponse = await http.post(
        Uri.parse(fundUrl),
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
          "x-auth-token": widget.token
        });
    if (statusResponse.statusCode != 201) {
      Alert(
        useRootNavigator:false,
        context: context,
        type: AlertType.error,
        desc: "Transaction unsuccessful",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }else{

      Fluttertoast.showToast(
          msg: "Account funded with  $amount chi 🤑",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.of(context).push(
          MaterialPageRoute(
              builder:(context)=> LoadDash(token: widget.token)));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          //  key: _formKey,
          child: Column(
              children: [
                PageTitle(pageTitle: 'Fund Wallet'),
                SizedBox(height: getProportionateScreenHeight(20.0)),
                Text('Amount',
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16.0,
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

                DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['ETH','CHI','BTC','TRON']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                SizedBox(height:getProportionateScreenHeight(40)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: DefaultButton(text: 'Done',
                      press: (){
                        fundWallet();
                      }
                  ),
                )
              ] ),
        )
    );
  }
}
