import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

enum MessageType { text, image, video }

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    required String fromId,
    required String toId,
    required String msg,
    required bool read,
    required DateTime sent,
    required MessageType messageType,
    required String chatId,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
