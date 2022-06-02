import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveawayui/screens/spray_screen.dart';
import '../colors.dart';
import '../constants.dart';
import '../screens/Transactions.dart';
import '../screens/controller/spray_controller.dart';
import '../screens/create_event.dart';
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
  @override
  _SprayState createState() => _SprayState();
}

class _SprayState extends State<Spray> {
  @override
  void initState() {
    // checkEventStatus();
    data = controller.getAllTransactions();
    super.initState();
  }

  late var data; bool isRefresh = false;
  final k = Get.lazyPut(() => HomeController());
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // margin: EdgeInsets.only(bottom: 240.0),
        color: Color(0xFFFFFFFF),
        child: Column(children: [
          Stack(children: [
            Container(
              height: Get.height * .35,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(60)),
                color: deepGreen,
              ),
            ),
            Container(
              height: Get.height * .35,
              child: CustomPaint(
                size: Size(
                    Get.width,
                    (Get.width)
                        .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.03),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  margin: EdgeInsets.only(top: 25.0),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/image1.png',
                              height: getProportionateScreenHeight(70)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // margin: EdgeInsets.only(
                              // right: getProportionateScreenWidth(40)),
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
                          ),
                        ],
                      ),
                      Icon(Icons.notifications_none_outlined,
                          size: 40.0, color: Colors.white)
                    ],
                  ),
                ),
                Container(
                    // height: ,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        left: getProportionateScreenWidth(40.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\$${userModel.user!.amount!.toStringAsFixed(2)}',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 40.0,
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
          ]),
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
            margin: EdgeInsets.only(
                right: Get.width * 0.4), //getProportionateScreenWidth(120)
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
              onRefresh: () {
                setState(() {
                  isRefresh = true;
                  data = controller.getAllTransactions();
                });
                return data;
              },
              child: FutureBuilder(
                future: data,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                  isRefresh = false;
                    if (snapshot.data['status'] == 403) {
                      return Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Unable to load Transactions"),
                          ElevatedButton(onPressed: ()=> setState((){data = controller.getAllTransactions();}), child: Text('Reload'))
                        ],
                      ));
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
                                        message: '${data[index].type}',
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
                                settings:
                                    RouteSettings(name: Transactions.routeName),
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
                  return (!isRefresh) ? loadingDash() : Container();
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
                  print(appSettings);
                  // appSettings['lastEventTime'] = 0;
                  if(appSettings['lastEventTime'] > 0){
                    Get.to(SprayScreen(), arguments: appSettings['eventDetails']);
                  } else {
                    pushNewScreen(context,
                        //  settings: RouteSettings(name: CreateEvent.routeName),
                        screen: CreateEvent(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  margin: EdgeInsets.only(
                    left: getProportionateScreenWidth(20),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                   appSettings['hasEvent'] ? "My Event" : "Create Event",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: Color(0xFF38A3A5),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: controller.getAllTransactions,
                child: Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
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

class RPSCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  Paint paint0 = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
     
         
    Path path0 = Path();
    path0.moveTo(0,0);
    path0.lineTo(size.width*0.9987600,0);
    path0.lineTo(size.width*0.9994200,size.height*0.2007363);
    path0.lineTo(size.width*0.5058400,size.height*0.9986613);
    path0.lineTo(0,size.height*1.0014458);
    path0.lineTo(0,0);
    path0.close();

    canvas.drawPath(path0, paint0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
