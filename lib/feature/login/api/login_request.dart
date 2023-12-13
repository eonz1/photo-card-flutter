import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginRequest {
  String? userId = "";
  String? password = "";

  LoginRequest({this.userId, this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
