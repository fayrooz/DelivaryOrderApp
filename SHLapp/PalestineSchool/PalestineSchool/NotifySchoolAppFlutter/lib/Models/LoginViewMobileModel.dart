import 'package:meta/meta.dart';
import 'dart:convert';


class LoginViewMobileModel {
  String username;
  String password;
  int deviceOsTypeId;
  String token;

  LoginViewMobileModel({
    required this.username,
    required this.password,
    required this.deviceOsTypeId,
    required this.token,
  });

  factory LoginViewMobileModel.fromJson(Map<String, dynamic> json) {
    return LoginViewMobileModel(
      username: json["Username"],
      password: json["Password"],
      deviceOsTypeId: json["DeviceOsTypeId"],
      token: json["Token"],
    );
  }
}