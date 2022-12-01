
import 'dart:convert';

LoginLogtViewMobileModel loginLogtViewMobileModelFromJson(String str) => LoginLogtViewMobileModel.fromJson(json.decode(str));

String loginLogtViewMobileModelToJson(LoginLogtViewMobileModel data) => json.encode(data.toJson());

class LoginLogtViewMobileModel {
  LoginLogtViewMobileModel({
    required this.customerId,
    required this.deviceOsTypeId,
    required this.token,
    required this.deviceInfo,
  });

  int customerId;
  int deviceOsTypeId;
  String token;
  String deviceInfo;

  factory LoginLogtViewMobileModel.fromJson(Map<String, dynamic> json) => LoginLogtViewMobileModel(
    customerId: json["CustomerId"],
    deviceOsTypeId: json["DeviceOsTypeId"],
    token: json["Token"],
    deviceInfo: json["DeviceINFO"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerId": customerId,
    "DeviceOsTypeId": deviceOsTypeId,
    "Token": token,
    "DeviceINFO": deviceInfo,
  };
}