// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['userId'] as String? ?? "",
      fullname: json['fullname'] as String? ?? "",
      email: json['email'] as String? ?? "",
      password: json['password'] as String? ?? "",
      PushToken: json['PushToken'] as String? ?? "",
      pic: json['pic'] as String? ?? "",
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'fullname': instance.fullname,
      'email': instance.email,
      'password': instance.password,
      'PushToken': instance.PushToken,
      'pic': instance.pic,
    };
