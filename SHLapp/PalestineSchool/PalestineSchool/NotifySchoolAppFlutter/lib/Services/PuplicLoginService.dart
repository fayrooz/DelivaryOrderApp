import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Util/Constants.dart';
import '../Models/LoginPuplicData.dart';



Future<LoginPuplicData?> PuplicLoginPost () async {
  var url =   BaseURL + '/api/Mobile/LoginPublic';


  SharedPreferences prefs = await SharedPreferences.getInstance();
  String FCMtoken = prefs.getString("FCMtoken") ?? "";



  Map data = {

    "deviceOsTypeId": 1,
    "token": FCMtoken
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );

  print("${response.statusCode}");

  print("${response.body}");
  if(response.statusCode == 404){
    return null;
  }else{
    return LoginPuplicDataFromJson(response.body);
  }



}