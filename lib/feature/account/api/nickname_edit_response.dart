import 'package:json_annotation/json_annotation.dart';

part 'nickname_edit_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NicknameEditResponse {
  String? nickname = "";

  NicknameEditResponse({this.nickname});

  factory NicknameEditResponse.fromJson(Map<String, dynamic> json) =>
      _$NicknameEditResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NicknameEditResponseToJson(this);
}
