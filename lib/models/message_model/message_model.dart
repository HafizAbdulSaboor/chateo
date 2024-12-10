import 'package:freezed_annotation/freezed_annotation.dart';
part 'message_model.freezed.dart';
part 'message_model.g.dart';

enum MessageType { text, image, video }

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    @Default("") String id,
    @Default("") String fromId,
    @Default("") String toId,
    @Default("") String msg,
    @Default(false) bool read,
    @Default("") String sent,
    @Default("") String messageType,
    @Default("") String chatId,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
