import 'dart:convert';

ApiDataSend apiDataSendFromJson(String str) => ApiDataSend.fromJson(json.decode(str));

String apiDataSendToJson(ApiDataSend data) => json.encode(data.toJson());

class ApiDataSend {
  ApiDataSend({
    required this.customerId,
    required this.deviceOsTypeId,
    required this.token,
    required this.maxId,
  });

  int customerId;
  int deviceOsTypeId;
  String token;
  int maxId;

  factory ApiDataSend.fromJson(Map<String, dynamic> json) => ApiDataSend(
    customerId: json["CustomerId"],
    deviceOsTypeId: json["DeviceOsTypeId"],
    token: json["Token"],
      maxId: json["maxId"]
  );

  Map<String, dynamic> toJson() => {
    "CustomerId": customerId,
    "DeviceOsTypeId": deviceOsTypeId,
    "Token": token,
    "maxId": maxId,
  };
}