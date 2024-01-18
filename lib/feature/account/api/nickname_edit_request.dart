import 'package:json_annotation/json_annotation.dart';

part 'nickname_edit_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NicknameEditRequest {
  String? nickname = "";

  NicknameEditRequest({this.nickname});

  factory NicknameEditRequest.fromJson(Map<String, dynamic> json) =>
      _$NicknameEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NicknameEditRequestToJson(this);
}
