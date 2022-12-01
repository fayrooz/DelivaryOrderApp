

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/ApiDataSend.dart';
import '../Util/Constants.dart';
getStudentLists (ApiDataSend obj) async {

  //await Future.delayed(const Duration(seconds: 2));

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String FCMtoken = prefs.getString("FCMtoken") ?? "";
  var url =  BaseURL + '/api/Mobile/CustomerServices';

  Map data = {
    "customerId": obj.customerId,
    "deviceOsTypeId": 1,
    "token": FCMtoken,

  };
  print(data);
  //encode Map to JSON
  var body = json.encode(data);
  String token = obj.token;
  var response = await http.post( Uri.parse(url),
      headers: {'Authorization': 'Bearer $token',
        "Accept": "application/json",
        "content-type":"application/json"},
      body: body
  );


  print("${response.body}");


  if(response.statusCode == 404){
    return "null";
  }
  else{
    return response.body;

  }



}

