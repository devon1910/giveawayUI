import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/components/ActionListTile.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';
import '../size_config.dart';
import '../widgets.dart';
import 'controller/spray_controller.dart';

class Transactions extends StatefulWidget {
  static String routeName = "/transactions";

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  String dropdownValue = 'Transaction type';
  // int transLength = 0;
  // String transType = "";
  // var transData, data;
  // int subColor = 0xFF006400;
  // String img = "assets/arrow-down-right-circle.png";

  @override
  void initState() {
    allTransactions = controller.getAllTransactions(length: 10);
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          isLast.value = true;
          print('At the bottom');
        }
      }
    });
    super.initState();
    // setState(() {
    //   var transactions = json.decode(widget.trans.body);
    //   Map<String, dynamic> transMap = transactions;
    //   List transList = transMap['data'];
    //   data = transMap['data'];
    //   transLength = transList.length;
    //   transType = data[transLength - 1]['type'];
    //   updateActionTile();
    // });
  }

  // void updateActionTile() {
  //   if (transType == "SEND") {
  //     subColor = 0xFFDC143C;
  //     img = "assets/Bitcoin.png";
  //   }
  // }

  var allTransactions;
  var data;
  final k = Get.lazyPut(() => HomeController());
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    notificationAreaStyle(white);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => updateTransactionByCategory('Event'),
      ),
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
              splashColor: primaryColor.withOpacity(.6),
              highlightColor: white,
              onTap: () => Get.back(),
              child:
                  Ink(child: Icon(Icons.arrow_back_ios, color: primaryColor))),
          title: Text(
            'Transactions',
            style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    color: Color(0xff3F51B5),
                    fontSize: 35.0,
                    fontWeight: FontWeight.w800)),
          )
          // Container(
          //           margin: EdgeInsets.fromLTRB(40, 15, 0, 10),
          //           child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceAround,
          //               children: [
          //                 Text(
          //                   'Transactions',
          //                   style: GoogleFonts.nunito(
          //                       textStyle: TextStyle(
          //                           color: Color(0xff3F51B5),
          //                           fontSize: 45.0,
          //                           fontWeight: FontWeight.w800)),
          //                 ),
          //                 Icon(
          //                   Icons.search,
          //                   size: 30.0,
          //                   color: Color(0xff3F51B5),
          //                 )
          //               ])),
          ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: grey.withOpacity(.2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.symmetric(horizontal: Get.width * .1),
                padding: EdgeInsets.only(right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xff3F51B5),
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Text(
                        'All',
                        style: TextStyle(
                          color: Colors.white,
                          //backgroundColor:
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      underline: Container(),
                      value: dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      iconSize: 30,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      // underline: Container(
                      //   height: 2,
                      //   color: Colors.deepPurpleAccent,
                      // ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Transaction type',
                        'Deposit',
                        'Withdraw',
                        'Send',
                        'Event'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300)),
                        );
                      }).toList(),
                    ),
                    Icon(Icons.calendar_today, color: Color(0xff3F51B5))
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: refreshData,
                  child: FutureBuilder(
                    future: allTransactions,
                    // initialData: InitialData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data['status'] == 403) {
                          return Center(
                              child: Text("Unable to load Transactions"));
                        }

                        if (snapshot.hasData) {
                          data = snapshot.data['message'];
                          return Column(
                            children: [
                              Expanded(
                                child: MediaQuery.removePadding(
                                  removeTop: true,
                                  context: context,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          controller: _controller,
                                            itemCount: data.length,
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
                                      Obx(() => isLast.value ? ElevatedButton(onPressed: loadMore, child: Text('load more'), ) : Container())
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                              child: Text("Unable to load Transactions"));
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
            ],
          ),
        ),
      ),
    );
  }

  RxBool isLoading = false.obs;
  int currentPosition = 0;
  int currentPage = 1;
  List sorted = [];
  late int totalPage;
  final _controller = ScrollController();
  RxBool isLast = false.obs;

  // late int totalLength;
  // late TransactionData trans;
  updateTransactionByCategory(category) async {
    isLoading.value = true;
    sorted.clear();
    allTransactions = await controller.getAllTransactions(length: 1000);
    // totalLength = allTransactions['message'].length;
    totalPage = (allTransactions['message'].length / 10).ceil();
    while (sorted.length < 10) {
      for (var i = currentPosition; i < (currentPosition + 10); i++) {
        var toAdd = allTransactions['message'][i][category] == category;
        if (toAdd) sorted.add(allTransactions['message'][i].toJson());
        if (sorted.length == 10) {
          currentPosition = i;
          break;
        }
      }

      if (sorted.length != 10) currentPosition += 10;
    }

    print(sorted);
    isLoading.value = false;
  }

  loadMore({category}) async {
    isLast.value = false;
    if(currentPosition == 0){
      currentPosition = 10;
      allTransactions = await controller.getAllTransactions(length: 1000);
      // totalLength = allTransactions['message'].length;
      totalPage = (allTransactions['message'].length / 10).ceil();
      while (sorted.length < ((sorted.length > 10) ? (currentPosition + 10) : (currentPosition + 20))) {
        for (var i = currentPosition; i < (currentPosition + 10); i++) {
          var toAdd = category == null ? true : allTransactions['message'][i][category] == category;
          if (toAdd) sorted.add(allTransactions['message'][i].toJson());
          if (sorted.length == (currentPosition + 10)) {
            currentPosition = i;
            break;
          }
        }

        if (sorted.length != 10) currentPosition += 10;
      }}
  }

  Future<void> refreshData() async {
    allTransactions = await controller.getAllTransactions(length: 1000);
    print(allTransactions.toString() + "------- all trans");
  }
}
