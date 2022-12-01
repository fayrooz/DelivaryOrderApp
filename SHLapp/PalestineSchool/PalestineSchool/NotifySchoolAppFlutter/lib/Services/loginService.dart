import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/LoginViewMobileModel.dart';
import '../Models/ReturnedApiLoginData.dart';
import '../Util/Constants.dart';







Future<ReturnedApiLoginData?> LoginPostRequest (LoginViewMobileModel loginObj) async {
  var url =  BaseURL + '/api/Mobile/login';


  SharedPreferences prefs = await SharedPreferences.getInstance();
  String FCMtoken = prefs.getString("FCMtoken") ?? "";

  Map data = {
    "username": loginObj.username,
    "password": loginObj.password,
    "deviceOsTypeId": 1,
    "token": FCMtoken
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print("${response.body}");

  if(response.statusCode == 404){
    return null;
  }else{
    return returnedApiLoginDataFromJson(response.body);
  }



}