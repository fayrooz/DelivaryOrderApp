// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    username: json['username'] as String,
    password: json['password'] as String,
    deviceOsTypeId: json['deviceOsTypeId'] as int,
    token: json['token'] as String?

  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'deviceOsTypeId': instance.deviceOsTypeId,
      'token': instance.token
    };
