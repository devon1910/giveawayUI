import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/ActionListTile.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config.dart';

class Transactions extends StatefulWidget {
  static String routeName="/transactions";
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  String dropdownValue = 'Transaction type';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children:[
            Container(
              margin: EdgeInsets.fromLTRB(40, 45, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Transactions',style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          color: Color(0xff3F51B5), fontSize: 45.0, fontWeight: FontWeight.w800)),
                  ),
                  Icon(Icons.search,
                  size: 30.0,
                  color: Color(0xff3F51B5),
                  )]
            )
      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color:Color(0xff3F51B5) ,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.all(15),
                      child: Text('All',
                      style: TextStyle(
                        color: Colors.white,
                        //backgroundColor:
                      ),),
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
                  items: <String>['Transaction type','Deposit', 'Withdraw', 'Send']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                    Icon(Icons.calendar_today,
                        color: Color(0xff3F51B5))
                  ],
                ),
              ActionListTile(
                  color: 0xFFEDF1F9,
                  img: 'assets/Bitcoin.png',
                  heading: '\$ 204',
                  subheading: '10.57PM',
                  message: 'Redeemed',
                  date:'Aug 16,2019'
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              ActionListTile(
                  color: 0xFFF4F2F2,
                  img: 'assets/arrow-down-right-circle.png',
                  heading: '\$ 695.03',
                  subheading: '3.21 ETH',
                  message: 'Deposited',
                  date:'Aug 16,2019'
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              ActionListTile(
                  color: 0xFFD7E2F8,
                  img: 'assets/arrow-up-right-circle.png',
                  heading: '\$ 250',
                  subheading: '37.81 NEO',
                  message: 'Sent',
                  date:'Aug 10,2019'
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              ActionListTile(
                  color: 0xFFE0E7CC,
                  img: 'assets/Bitcoin.png',
                  heading: '\$ 204',
                  subheading: '0.021 ETH',
                  message: 'Withdrawn',
                  date:'Aug 16,2019'
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              ActionListTile(
                  color: 0xFFEDF1F9,
                  img: 'assets/arrow-down-right-circle.png',
                  heading: '\$ 695.03',
                  subheading: '3.21 ETH',
                  message: 'Deposited',
                  date:'Aug 16,2019'
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              ActionListTile(
                  color: 0xFFD7E2F8,
                  img: 'assets/arrow-down-right-circle.png',
                  heading: '\$ 695.03',
                  subheading: '3.21 ETH',
                  message: 'Deposited',
                  date:'Aug 16,2019'
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              ActionListTile(
                  color: 0xFFD7E2F8,
                  img: 'assets/Bitcoin.png',
                  heading: '\$ 695.03',
                  subheading: '3.21 ETH',
                  message: 'Deposited',
                  date:'Aug 16,2019'
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              ActionListTile(
                  color: 0xFFEDF1F9,
                  img: 'assets/arrow-up-right-circle.png',
                  heading: '\$ 695.03',
                  subheading: '3.21 ETH',
                  message: 'Deposited',
                  date:'Aug 16,2019'
              ),
              SizedBox(height: getProportionateScreenHeight(5))
            ]
          ),
        ),
      ),
    );
  }
}
