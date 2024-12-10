// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      id: json['id'] as String? ?? "",
      fromId: json['fromId'] as String? ?? "",
      toId: json['toId'] as String? ?? "",
      msg: json['msg'] as String? ?? "",
      read: json['read'] as bool? ?? false,
      sent: json['sent'] as String? ?? "",
      messageType: json['messageType'] as String? ?? "",
      chatId: json['chatId'] as String? ?? "",
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromId': instance.fromId,
      'toId': instance.toId,
      'msg': instance.msg,
      'read': instance.read,
      'sent': instance.sent,
      'messageType': instance.messageType,
      'chatId': instance.chatId,
    };
