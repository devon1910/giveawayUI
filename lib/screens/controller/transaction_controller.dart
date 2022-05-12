import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'spray_controller.dart';

class TransactionController extends GetxController{

  String dropdownValue = 'Transaction type';

  RxList allTransactions = [].obs;
  RxBool isLoadingInit = false.obs;
  RxBool dataIsLoaded = false.obs;
  RxBool isLoadedMore = false.obs;
  int subColor = 0xFF006400;
  String img = "assets/arrow-down-right-circle.png";
  int totalPage = 0;
  int currentPage = 1;
  // var data;
  final controller = ScrollController();
  RxBool isLast = false.obs;

  final _ = Get.lazyPut(() => HomeController());
  final _homeController = Get.find<HomeController>();

  //this function will be called once during the init
  getTransactions() async {
    // await Future.delayed(Duration(seconds: 2));
    isLoadingInit.value = true; //true
    var data = await _homeController.getAllTransactions(length: 10, page: 1);
    if (data['status'] == 200) {
      allTransactions.value = data['message'];
    } else {
      isLoadingInit.value = false; //false
      return;
    }
    totalPage = (allTransactions.length / 10).ceil();
    isLoadingInit.value = false; //false
    dataIsLoaded.value = true;
  }
  

  loadMore() async {
    // print("calling more");
    // print(isLast.value);
    if(isLast.value){
      return;
    }
    isLoadedMore.value = true;
    currentPage++;
    var data =
        await _homeController.getAllTransactions(length: 10, page: currentPage);
    if (data['status'] != 200) {
      // print("calling more on error");
      isLast.value = true;
      isLoadedMore.value = false;
      return;
    }
    allTransactions.addAll(data['message']);
    // print("end calling more");

    isLoadedMore.value = false;
  }

}