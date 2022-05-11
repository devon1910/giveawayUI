
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../screens/Transactions.dart';
import '../screens/controller/spray_controller.dart';
import '../widgets.dart';
import '/screens/deposit.dart';
import '/screens/receive.dart';
import '/screens/send.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../size_config.dart';
import 'ActionListTile.dart';
import 'ActionTile.dart';

class Spray extends StatefulWidget {
  // const Spray({required this.token,
  //   required this.trans,
  //   required this.user,
  //   required this.userEvent,
  //   required this.allEvents});
  // final  trans,user,userEvent,allEvents;
  // final String token;
  @override
  _SprayState createState() => _SprayState();
}

class _SprayState extends State<Spray> {
  @override
  void initState() {
    data = controller.getAllTransactions(length: 5);
    super.initState();
    // setState(() {
    //  // virtualAmount=widget.user['data']['amount'];
    //   amount=widget.user['data']['amount'];
    // //  amount = virtualAmount.toDouble();
    //   username = widget.user['data']['username'];
    //   if(widget.userEvent.statusCode == 200) {
    //     final responseEJson = json.decode(widget.userEvent.body);
    //     //converting data from data parameter to List Then to map
    //     //to access its Length
    //     List dataLength = responseEJson['data'];
    //     Map eventsMap = dataLength.asMap();
    //     int lastIndex=dataLength.length-1;
    //     eventStatus = eventsMap[lastIndex]['status'];
    //     print('event Status: '+eventStatus);
    //     ecode=  eventsMap[lastIndex]['event_code'];
    //     print('event code: '+ecode);
    //   }
    //   if (widget.trans.statusCode == 200) {
    //     var transactions = json.decode(widget.trans.body);
    //     Map<String, dynamic> transMap = transactions;
    //     List transList=transMap['data'];
    //     data = transMap['data'];
    //     transLength=transList.length;
    //     transType=data[transLength-1]['type'];
    //     isTran = true;
    //   }
    //   updateActionTile();
    // });
  }

  late var data;
  final k = Get.lazyPut(() => HomeController());
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // margin: EdgeInsets.only(bottom: 240.0),
        color: Color(0xFFFFFFFF),
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
              gradient: LinearGradient(colors: [
                Color(0xFF3F51B5),
                Color(0xFF38A3A5),
                Color(0xFF38A3A5),
                Color(0xFF38A3A5)
              ]),
              //borderRadius:
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                margin: EdgeInsets.only(top: 25.0),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/image1.png',
                        height: getProportionateScreenHeight(70)),
                    Container(
                      margin:
                          EdgeInsets.only(right: getProportionateScreenWidth(30)),
                      child: Column(
                          //  margin: EdgeInsets.only(right: 20),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hello ${userModel.user!.username}',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w800))),
                            Text('Take a look at your\nwallet. Opor!',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w300))),
                          ]),
                    ),
                    // Icon(Icons.notifications_none_outlined,
                    //     size: 40.0, color: Colors.white)
                  ],
                ),
              ),
              Container(
                  // height: ,
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(40.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\$${userModel.user!.amount!.toStringAsFixed(2)}',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 38.0,
                                  fontWeight: FontWeight.w900))),
                      Text(
                        'Balance',
                        //textAlign: TextAlign.start,
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  ))
            ]),
          ),
          //SizedBox(height: getProportionateScreenHeight(5.0),),
          Container(
            //   margin: EdgeInsets.only(bottom: 30.0),
            padding: EdgeInsets.fromLTRB(60, 20, 50, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionTile(
                  color: Color(0xffEDF1F9),
                  image: Image.asset('assets/deposit.png'),
                  text: 'Deposit',
                  onClick: () {
                    pushNewScreen(context,
                        //  settings: RouteSettings(name: CreateEvent.routeName),
                        screen: Deposit(token: "widget.token"),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino);
                  },
                ),
                ActionTile(
                  color: Color(0xffF4F2F2),
                  image: Image.asset('assets/send.png'),
                  text: 'Send',
                  onClick: () {
                    pushNewScreen(context,
                        //  settings: RouteSettings(name: CreateEvent.routeName),
                        screen: Transfer(token: "widget.token"),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino);
                  },
                ),
                ActionTile(
                  color: Color(0xFFD2E1FF),
                  image: Image.asset('assets/receive.png'),
                  text: 'Receive',
                  onClick: () {
                    pushNewScreen(context,
                        //  settings: RouteSettings(name: CreateEvent.routeName),
                        screen: Receive(token: "widget.token"),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino);
                  },
                ),
                ActionTile(
                  color: Color(0xffEDF1F9),
                  image: Image.asset('assets/redeem.png'),
                  text: 'Redeem',
                  onClick: () {},
                ),
              ],
            ),
          ),
          Container(
            //  color: Colors.red,
            margin: EdgeInsets.only(right: Get.width * 0.4),//getProportionateScreenWidth(120)
            child: Text(
              'Latest transaction',
              textAlign: TextAlign.start,
              style: GoogleFonts.titilliumWeb(
                textStyle: TextStyle(
                    color: Color(0xFF0D1F3C),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Container(
            height: Get.height * .22,
            child: RefreshIndicator(
              onRefresh: ()=> data = controller.getAllTransactions(),
              child: FutureBuilder(
                future: data,
                // initialData: InitialData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  
                  if (snapshot.connectionState == ConnectionState.done) {
            
                    if(snapshot.data['status'] == 403){
                      return Center(child: Text("Unable to load Transactions"));
                    }
                    if (snapshot.hasData) {
                    var data = snapshot.data['message'];
                      return Column(
                        children: [
                          Expanded(
                            child: MediaQuery.removePadding(
                              removeTop: true,
                              context: context,
                              child: ListView.builder(
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return ActionListTile(
                                      img: controller.img,
                                      heading:
                                          '${data[index].transactionAmount} chi',
                                      subheading: data[index].description,
                                      subHeadColor: controller.subColor,
                                      message:
                                          '${data[index].type}',
                                      date:
                                          '${data[index].transactionDate.split(',')[0]}',
                                      color: 0xFFEDF1F9);
                                  }),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(15)),
                          GestureDetector(
                            onTap: () {
                              pushNewScreenWithRouteSettings(
                                context,
                                settings: RouteSettings(name: Transactions.routeName),
                                screen: Transactions(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Text('See all Transactions',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Color(0xFF3F51B5),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600))),
                          ),
                        ],
                      );
                    }
                
                    if (snapshot.hasError) {
                      return Center(child: Text("Unable to load Transactions"));
                    }
                    
                    if (!snapshot.hasData) {
                      return Column(children: [
                        SizedBox(
                          height: getProportionateScreenHeight(30),
                        ),
                        Image.asset('assets/Mask.png',
                            height: 50.0, color: Colors.grey),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        Container(
                          child: Center(
                            child: Text('No Transactions',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        color: Color(0xFF3F51B5),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600))),
                          ),
                        ),
                      ]);
                    }
                  }
                  return loadingDash();
                },
              ),
            ),
          ),
           SizedBox(height: getProportionateScreenHeight(40)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // if (eventStatus == "ACTIVE") {
                  //   // endEvent();
                  // } else {
                  //   pushNewScreen(context,
                  //       //  settings: RouteSettings(name: CreateEvent.routeName),
                  //       screen: CreateEvent("widget.token"),
                  //       withNavBar: false,
                  //       pageTransitionAnimation:
                  //           PageTransitionAnimation.cupertino);
                  // }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  margin: EdgeInsets.only(left: getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                      "Create", //eventStatus == "ACTIVE" ? "End Event" : "Create Event", //TODO
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: Color(0xFF38A3A5),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600))),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // loadDialog();
                  controller.getAllTransactions();
                },
                child: Container(
                  margin: EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                      color: Color(0xFF3F51B5),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text('Join Event',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600))),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
        ]),
      ),
    );
  }
}
