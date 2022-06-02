import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveawayui/screens/dashboard.dart';

import '../../models/UserModel.dart';
import '../../components/loadDash.dart';
import '../../constants.dart';
import '../../functions.dart';
import '../../widgets.dart';

class SigninControler extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  // TextEditingController fullname = TextEditingController();
  // TextEditingController username = TextEditingController();
  // TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool obscure = true;
  bool isLoading = false;
  
  void submit() async{
    if (formKey.currentState!.validate()) {
      isLoading = true;
      update();
      var body = {
        "email": email.text.trim(),
        "password": password.text.trim(),
      };

      var response = await httpPost(url: 'https://spray-dev.herokuapp.com/api/users/auth/', body: body);
      if (response['status'] == 200 && response['message'] == "authentication successful") {
          kSuccessMessage(title: "Welcome", message: "You have successfully login");
          userModel = UserModel.fromJson(response);
          print(response.toString() + "---------------------- ser response data ----------------------------------");
          generalFunction.updateUser(user: response);
          generalFunction.updateSettings(setting: {"isLogin": true});
          isLoading = false;
          Get.toNamed(Dashboard.routeName);
          update();
          return;
      }

      // kErrorMessage(title: "Invalid Credentials", message: response['message']);
      alert(title: response['message'], isSuccess: false);
      isLoading = false;
      update();
      return;

    }else{
      return;
    }

  }
 

}
