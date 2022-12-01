import 'dart:convert';

LogoutViewMobileModel logoutViewMobileModelFromJson(String str) => LogoutViewMobileModel.fromJson(json.decode(str));

String logoutViewMobileModelToJson(LogoutViewMobileModel data) => json.encode(data.toJson());

class LogoutViewMobileModel {
  LogoutViewMobileModel({
    required this.customerId,
    required this.deviceOsTypeId,
    required this.token,
  });

  int customerId;
  int deviceOsTypeId;
  String token;

  factory LogoutViewMobileModel.fromJson(Map<String, dynamic> json) => LogoutViewMobileModel(
    customerId: json["CustomerId"],
    deviceOsTypeId: json["DeviceOsTypeId"],
    token: json["Token"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerId": customerId,
    "DeviceOsTypeId": deviceOsTypeId,
    "Token": token,
  };
}

