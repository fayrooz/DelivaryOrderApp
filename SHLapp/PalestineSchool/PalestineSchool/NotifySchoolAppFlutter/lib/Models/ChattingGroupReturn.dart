
import 'dart:convert';
import 'dart:ffi';

class ChattingGroupReturn {


  final int groupId;
  final String groupName;
 final String serviceTitle;

  ChattingGroupReturn.fromJson(Map<String, dynamic> json)
      : groupId = json['groupId'],
        groupName = json['groupName'],
      serviceTitle = json['serviceTitle']
  ;
}

//
// class ChattingReturn {
//
//
//   final int id;
//   final String msgTs;
//   final String msgText;
//   final bool msgFromAdmin;
//   final String adminSenderName;
//
//   ChattingReturn.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         msgTs = json['msgTs'],
//         msgText = json['msgText'],
//         msgFromAdmin = json['msgFromAdmin'],
//         adminSenderName = json['adminSenderName']
//   ;
// }


//
ChattingReturn ChattingGroupReturnFromJson(String str) => ChattingReturn.fromJson(json.decode(str));

String ChattingGroupReturnToJson(ChattingReturn data) => json.encode(data.toJson());

class ChattingReturn {
  ChattingReturn({
    required this.id,
    required this.msgTs,
    required this.msgText,
    required this.msgFromAdmin,
    required this.adminSenderName,


  });

  int id;
  String msgTs;
  String msgText;
  bool msgFromAdmin;
  String adminSenderName;

  factory ChattingReturn.fromJson(Map<String, dynamic> json) => ChattingReturn(
    id: json["id"],
    msgTs: json["msgTs"],
    msgText: json["msgText"],
    adminSenderName: json["adminSenderName"],
    msgFromAdmin: json["msgFromAdmin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "msgTs": msgTs,
    "msgText": msgText,
    "msgFromAdmin": msgFromAdmin,
    "adminSenderName": adminSenderName,
  };
}

///////////////////////////


LatestChattingReturn LatestChattingGroupReturnFromJson(String str) => LatestChattingReturn.fromJson(json.decode(str));

String LatestChattingGroupReturnToJson(LatestChattingReturn data) => json.encode(data.toJson());

class LatestChattingReturn {
  LatestChattingReturn({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.msgText,
    required this.msgTs,
    required this.groupId,
    required this.groupName,

  });

  int id;
  int customerId;
  String customerName;
  String msgText;
  String msgTs;
  int groupId ;
  String groupName;


  factory LatestChattingReturn.fromJson(Map<String, dynamic> json) => LatestChattingReturn(
    id: json["id"],
    customerId: json["customerId"],
    customerName: json["customerName"],
    msgText: json["msgText"],
    msgTs: json["msgTs"],
    groupId: json["groupId"],
    groupName: json["groupName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customerId": customerId,
    "customerName": customerName,
    "msgText": msgText,
    "msgTs": msgTs,
    "groupId": groupId,
    "groupName": groupName,
  };
}
