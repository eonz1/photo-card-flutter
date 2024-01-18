import 'package:json_annotation/json_annotation.dart';

part 'password_edit_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PasswordEditRequest {
  String? currentPassword = "";
  String? newPassword = "";

  PasswordEditRequest({this.currentPassword, this.newPassword});

  factory PasswordEditRequest.fromJson(Map<String, dynamic> json) =>
      _$PasswordEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordEditRequestToJson(this);
}
