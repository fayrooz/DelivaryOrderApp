import 'dart:convert';

ApiSyncDataMaxIdSend apiSyncDataMaxIdSendFromJson(String str) => ApiSyncDataMaxIdSend.fromJson(json.decode(str));

String apiSyncDataMaxIdSendToJson(ApiSyncDataMaxIdSend data) => json.encode(data.toJson());

class ApiSyncDataMaxIdSend {
  ApiSyncDataMaxIdSend({
    required this.customerId,
    required this.deviceOsTypeId,
    required this.token,
    required this.maxId,
  });

  int customerId;
  int deviceOsTypeId;
  String token;
  int maxId;

  factory ApiSyncDataMaxIdSend.fromJson(Map<String, dynamic> json) => ApiSyncDataMaxIdSend(
    customerId: json["CustomerId"],
    deviceOsTypeId: json["DeviceOsTypeId"],
    token: json["Token  "],
    maxId: json["MaxId   "],
  );

  Map<String, dynamic> toJson() => {
    "CustomerId": customerId,
    "DeviceOsTypeId": deviceOsTypeId,
    "Token  ": token,
    "MaxId   ": maxId,
  };
}