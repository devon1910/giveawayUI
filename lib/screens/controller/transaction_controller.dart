import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'spray_controller.dart';

class TransactionController extends GetxController {
  RxString dropdownValue = 'Transaction type'.obs;

  RxList allTransactions = [].obs;
  RxBool isLoadingInit = false.obs;
  RxBool dataIsLoaded = false.obs;
  RxBool isLoadedMore = false.obs;
  int subColor = 0xFF006400;
  String img = "assets/arrow-down-right-circle.png";
  // int totalPage = 0;
  int currentPage = 1;
  // var data;
  final scrollController = ScrollController();
  RxBool isLast = false.obs;

  final _ = Get.lazyPut(() => HomeController());
  final _homeController = Get.find<HomeController>();

  String currentCategory = 'Transaction type';

  final transactionType = <String>[
    'Transaction type', //ALL
    'Deposit', // FUND
    'Withdraw', // REDEEM
    'Send', // SEND
    'Event' // EVENT
  ];

  final Map data = {

  };

  int recursion = 0;
  onChangeType({cat}) async {
    try{
      if(cat == currentCategory) return;
      isLast.value = false;
      allTransactions.clear();
      isLoadingInit.value = true;
      currentCategory = cat;
      currentPage = 1;
      print(cat);
      var data = await _homeController.getAllTransactions(length: 12, page: 1, category: currentCategory);

      if (data['status'] == 200) {
        allTransactions.value = data['message'];
      } else {
        isLoadingInit.value = false; //false
        return;
      }
      isLoadingInit.value = false; //false
      dataIsLoaded.value = true;

      isLoadingInit.value = false;
    }catch(e) {
      //  print('user throw $e');
      isLoadingInit.value = false;
      recursion = 0;
    }
   
  }

  //this function will be called once during the init
  getTransactions({transType}) async {
    if(currentCategory == transType) return;
    isLoadingInit.value = true; //true
    isLast.value = false;
    dropdownValue.value = 'Transaction type';
    currentCategory = 'Transaction type';
    currentPage = 1;
    var data = await _homeController.getAllTransactions(length: 12, page: 1);
    if (data['status'] == 200) {
      allTransactions.value = data['message'];
    } else {
      isLoadingInit.value = false; //false
      return;
    }
    isLoadingInit.value = false; //false
    dataIsLoaded.value = true;
  }

  loadMore() async {
    print("calling more1");
    print(isLast.value);
    if (isLast.value) {
      return;
    }
    isLoadedMore.value = true;
    currentPage++;
    print(currentCategory);
    print('$currentPage ------------------------page');
    var data =
          await _homeController.getAllTransactions(length: 12, page: currentPage, category: currentCategory);
    if (data['status'] != 200) {
      print("calling more on error");
      isLast.value = true;
      isLoadedMore.value = false;
      return;
    }
    allTransactions.addAll(data['message']);
    isLoadedMore.value = false;
    return ;

  }

}
