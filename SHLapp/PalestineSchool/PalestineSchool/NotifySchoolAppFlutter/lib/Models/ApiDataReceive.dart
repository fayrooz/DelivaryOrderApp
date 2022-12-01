import 'dart:convert';

ApiDataReceive apiDataReceiveFromJson(String str) => ApiDataReceive.fromJson(json.decode(str));

String apiDataReceiveToJson(ApiDataReceive data) => json.encode(data.toJson());

class ApiDataReceive {
  ApiDataReceive({
    required this.serviceId,
    required this.serviceTitle,
    required this.serviceBody,
    required this.title,
  });

  int serviceId;
  String serviceTitle;
  String serviceBody;
  String title;

  factory ApiDataReceive.fromJson(Map<String, dynamic> json) => ApiDataReceive(
    serviceId: json["serviceId"],
    serviceTitle: json["serviceTitle"],
    serviceBody: json["serviceBody"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "serviceId": serviceId,
    "serviceTitle": serviceTitle,
    "serviceBody": serviceBody,
    "title": title,
  };
}



class User {
  int serviceId;
  String serviceTitle;
  String serviceBody;
  String title;


  User(this.serviceId, this.serviceTitle,this.title,this.serviceBody);
  factory User.fromJson(dynamic json) {
    return User(json['serviceId'] as int, json['serviceTitle'] as String,json['title'] as String, json['serviceBody'] as String);
  }
  @override
  String toString() {
    return '{ ${this.serviceId}, ${this.serviceTitle} , ${this.serviceBody}, ${this.title} }';
  }
}


class DataReceive {


  final int serviceId;
  final String serviceTitle;
  final String serviceBody;
  final  String title;


  DataReceive.fromJson(Map<String, dynamic> json)
      : serviceId = json['serviceId'],
        serviceTitle = json['serviceTitle'],
        serviceBody = json['serviceBody'],
        title = json['title']
  ;
}


class DataReceive_AdminGroup {


  final int customerId;
  final String studentName;



  DataReceive_AdminGroup.fromJson(Map<String, dynamic> json)
      : customerId = json['customerId'],
        studentName = json['studentName']
  ;
}




