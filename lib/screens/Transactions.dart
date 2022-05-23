import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/components/ActionListTile.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';
import '../widgets.dart';
import 'controller/transaction_controller.dart';

class Transactions extends StatefulWidget {
  static String routeName = "/transactions";

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {

  final k = Get.lazyPut(() => TransactionController());
  final controller = Get.find<TransactionController>();

  @override
  void initState() {
    controller.getTransactions();
    controller.scrollController.addListener(() {
      if (controller.scrollController.position.atEdge) {
        bool isTop = controller.scrollController.position.pixels == 0;
        if (isTop) {
          return;
        } 
        controller.loadMore();
        
      }
    });
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    notificationAreaStyle(white);
    return Scaffold(
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
                    GestureDetector(
                      onTap: ()=> controller.getTransactions(transType: 'Transaction type'),
                      child: Container(
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
                    ),
                    Obx(() {
                        return DropdownButton<String>(
                          underline: Container(),
                          value: controller.dropdownValue.value,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          iconSize: 30,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          // underline: Container(
                          //   height: 2,
                          //   color: Colors.deepPurpleAccent,
                          // ),
                          onChanged: (String? newValue) {
                              controller.dropdownValue.value = newValue!;
                              controller.onChangeType(cat: newValue);
                          },
                          items: controller.transactionType.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w300)),
                            );
                          }).toList(),
                        );
                      }
                    ),
                    Icon(Icons.calendar_today, color: Color(0xff3F51B5))
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  return controller.isLoadingInit.value
                      ? loadingDash()
                      : !controller.dataIsLoaded.value
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Error loading transactions"),
                                ElevatedButton(
                                    onPressed: () => controller.getTransactions(),
                                    child: Text('Refresh'))
                              ],
                            ))
                          : Stack(
                              children: [
                                Column(
                                  children: [
                                    MediaQuery.removePadding(
                                      removeTop: true,
                                      context: context,
                                      child: Expanded(
                                        child: ListView.builder(
                                            controller: controller.scrollController,
                                            itemCount: controller.allTransactions.length,
                                            itemBuilder: (context, index) {
                                              return ActionListTile(
                                                  img: controller.img,
                                                  heading:
                                                      '${controller.allTransactions[index].transactionAmount} chi',
                                                  subheading:
                                                      controller.allTransactions[index]
                                                          .description,
                                                  subHeadColor:
                                                      controller.subColor,
                                                  message:
                                                      '${controller.allTransactions[index].type}',
                                                  date:
                                                      '${controller.allTransactions[index].transactionDate.split(',')[0]}',
                                                  color: 0xFFEDF1F9);
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                    bottom: 20,
                                    left: Get.width * .49,
                                    child: Obx(() => controller.isLoadedMore.value ? loadingDash() : Container() )
                          )],);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

