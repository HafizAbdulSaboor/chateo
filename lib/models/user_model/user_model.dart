import 'package:freezed_annotation/freezed_annotation.dart';
part "user_model.g.dart";
part "user_model.freezed.dart";

@Freezed()
class UserModel with _$UserModel {
  factory UserModel({
    @Default("") String userId,
    @Default("") String fullname,
    @Default("") String email,
    // @Default("") String phonenumber,
    @Default("") String password,
    @Default("") String PushToken,
    @Default("") String pic,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
