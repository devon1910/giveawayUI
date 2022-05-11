import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

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
    print(response.toString() + "------ response --------");
    return json.decode(response.body);
  }catch(e) {
    return {'status': 403, "message": "Error retrieving information, Please make sure your internet is turned on."};
  }
  

//   return {'status': json.decode(response.body)['status'], "message": json.decode(response.body)};
// return {'status': 403, "message": "Error retrieving information, Please make sure your internet is turned on."};
}
