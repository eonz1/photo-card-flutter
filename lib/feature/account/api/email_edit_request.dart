import 'package:json_annotation/json_annotation.dart';

part 'email_edit_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EmailEditRequest {
  String? userEmail = "";
  String? authNumber = "";

  EmailEditRequest({this.userEmail, this.authNumber});

  factory EmailEditRequest.fromJson(Map<String, dynamic> json) =>
      _$EmailEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EmailEditRequestToJson(this);
}
