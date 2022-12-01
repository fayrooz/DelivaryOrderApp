import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/ApiDataSend.dart';
import '../Util/Constants.dart';


 chattingGroupService (ApiDataSend obj) async {
  var url = BaseURL + '/api/Mobile/CustomerMessageGroups';


  SharedPreferences prefs = await SharedPreferences.getInstance();
  String FCMtoken = prefs.getString("FCMtoken") ?? "";

  Map data = {
    "customerId": obj.customerId,
    "deviceOsTypeId": 1,
    "token": FCMtoken
  };
  //encode Map to JSON

  var body = json.encode(data);
  String token = obj.token;
  var response = await http.post(Uri.parse(url),
      headers: {'Authorization': 'Bearer $token',
        "Accept": "application/json",
        "content-type":"application/json"},
      body: body
  );
  print("chattingGroupService${response.body}");
  if(response.statusCode == 404){
    return "null";
  }
  else{
    return response.body;

  }



}