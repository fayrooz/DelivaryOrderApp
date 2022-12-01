import 'dart:convert';

ApiSendMsg apiSendMsgFromJson(String str) => ApiSendMsg.fromJson(json.decode(str));

String apiSendMsgToJson(ApiSendMsg data) => json.encode(data.toJson());

class ApiSendMsg {
  ApiSendMsg({
    required this.customerId,
    required this.deviceOsTypeId,
    required this.token,
    required this.msgText,
  });

  int customerId;
  int deviceOsTypeId;
  String token;
  String msgText;

  factory ApiSendMsg.fromJson(Map<String, dynamic> json) => ApiSendMsg(
    customerId: json["CustomerId  "],
    deviceOsTypeId: json["DeviceOsTypeId  "],
    token: json["Token  "],
    msgText: json["MsgText  "],
  );

  Map<String, dynamic> toJson() => {
    "CustomerId  ": customerId,
    "DeviceOsTypeId  ": deviceOsTypeId,
    "Token  ": token,
    "MsgText  ": msgText,
  };
}
