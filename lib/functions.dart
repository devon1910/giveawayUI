import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'models/UserModel.dart';
import 'screens/landing_screen.dart';

Future httpPost({required String? url, body, header}) async {
  var response = await http.post(Uri.parse(url!),
      body: json.encode(body),
      headers: header ?? {"Content-Type": "application/json"});
  print(response.body);
  return json.decode(response.body);
}

Future httpGet({required String? url, Map<String, String>? header}) async {
  try{
    var response = await http.get(Uri.parse(url!), headers: header ?? {"Content-Type": "application/json"});
    // print(response.toString() + "------ response --------");
    return json.decode(response.body);
  }catch(e) {
    return {'status': 403, "message": "Error retrieving information, Please make sure your internet is turned on."};
  }
}

signOut(){
  Get.offAllNamed(LandingScreen.routeName);
  generalFunction.updateSettings(setting: {'isLogin': false});
  userStorage.erase();
}

Future<bool> refreshUserToken() async {
   var body = {
        "email": 'smart',
        "password": '123456',
      };
      // print('calling user auth');
    var response = await httpPost(url: 'https://spray-dev.herokuapp.com/api/users/auth/', body: body);
    if(response['status'] == 200 && response['message'] == "authentication successful"){
      userModel = UserModel.fromJson(response);
      generalFunction.updateUser(user: response);
      return true;
    }

  return false;
}