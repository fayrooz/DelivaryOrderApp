
import 'dart:convert';

LoginPuplicData LoginPuplicDataFromJson(String str) => LoginPuplicData.fromJson(json.decode(str));

String returnedApiLoginPuplicDataToJson(LoginPuplicData data) => json.encode(data.toJson());

class LoginPuplicData {
  LoginPuplicData({

    required this.token,
    required this.notRegistredUserMsg,
  });

  String notRegistredUserMsg;

  String token;


  factory LoginPuplicData.fromJson(Map<String, dynamic> json) => LoginPuplicData(

    token: json["token"],
    notRegistredUserMsg: json["notRegistredUserMsg"],
  );

  Map<String, dynamic> toJson() => {

    "token": token,
    "notRegistredUserMsg": notRegistredUserMsg,
  };
}


