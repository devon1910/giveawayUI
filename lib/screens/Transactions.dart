import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/ActionListTile.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert';
import '../size_config.dart';

class Transactions extends StatefulWidget {
  final trans;
  Transactions({required this.trans});
  static String routeName = "/transactions";
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  String dropdownValue = 'Transaction type';
  int transLength = 0;
  String transType = "";
  var transData, data;
  int subColor=0xFF006400;
  String img="assets/arrow-down-right-circle.png";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var transactions = json.decode(widget.trans.body);
      Map<String, dynamic> transMap = transactions;
      List transList = transMap['data'];
      data = transMap['data'];
      transLength = transList.length;
      transType = data[transLength - 1]['type'];
      updateActionTile();
    });
  }

  void updateActionTile(){
   if(transType=="SEND"){
     subColor=0xFFDC143C;
     img="assets/Bitcoin.png";

   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff3F51B5),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'All',
                      style: TextStyle(
                        color: Colors.white,
                        //backgroundColor:
                      ),
                    ),
                  ),
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
                    items: <String>[
                      'Transaction type',
                      'Deposit',
                      'Withdraw',
                      'Send'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Icon(Icons.calendar_today, color: Color(0xff3F51B5))
                ],
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(40, 15, 0, 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Transactions',
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: Color(0xff3F51B5),
                                  fontSize: 45.0,
                                  fontWeight: FontWeight.w800)),
                        ),
                        Icon(
                          Icons.search,
                          size: 30.0,
                          color: Color(0xff3F51B5),
                        )
                      ])),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ActionListTile(
                          img: img,
                          heading: '${data[index]['transaction_amount']} chi',
                          subheading: '$transType',
                          subHeadColor: subColor,
                          message: '${data[index]['payment_method']}',
                          date: '${data[index]['transaction_date']}',
                          color: 0xFFEDF1F9);
                    },
                    itemCount: transLength),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
