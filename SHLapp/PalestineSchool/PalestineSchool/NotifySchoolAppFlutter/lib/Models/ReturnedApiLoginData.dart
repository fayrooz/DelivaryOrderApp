import 'dart:convert';





ReturnedApiLoginData returnedApiLoginDataFromJson(String str) => ReturnedApiLoginData.fromJson(json.decode(str));

String returnedApiLoginDataToJson(ReturnedApiLoginData data) => json.encode(data.toJson());

class ReturnedApiLoginData {
  ReturnedApiLoginData({
    required this.customerId,
    required this.customerName,
    required this.customerPk,
    required this.token,
    required this.userType,
    required this.groupAdminSenderName,

  });

  int customerId;
  String customerName;
  String customerPk;
  String token;
  String userType;
  String? groupAdminSenderName;

  factory ReturnedApiLoginData.fromJson(Map<String, dynamic> json) => ReturnedApiLoginData(
    customerId: json["customerId"],
    customerName: json["customerName"],
    customerPk: json["customerPK"],
    token: json["token"],
    userType: json["userType"],
    groupAdminSenderName: json["groupAdminSenderName"],
  );

  Map<String, dynamic> toJson() => {
    "customerId": customerId,
    "customerName": customerName,
    "customerPK": customerPk,
    "token": token,
    "userType": userType,
    "groupAdminSenderName": groupAdminSenderName,
  };
}






chattingGroupReturn ChattingGroupReturnFromJson(String str) => chattingGroupReturn.fromJson(json.decode(str));

String ChattingGroupReturnToJson(ReturnedApiLoginData data) => json.encode(data.toJson());

class chattingGroupReturn {
  chattingGroupReturn({
    required this.groupId,
    required this.groupName,
    required this.serviceTitle,



  });

  int groupId;
  String groupName;
  String serviceTitle;


  factory chattingGroupReturn.fromJson(Map<String, dynamic> json) => chattingGroupReturn(
    groupId: json["groupId"],
    groupName: json["groupName"],
    serviceTitle: json["serviceTitle"],

  );

  Map<String, dynamic> toJson() => {
    "groupId": groupId,
    "groupName": groupName,
    "serviceTitle": serviceTitle,

  };
}
