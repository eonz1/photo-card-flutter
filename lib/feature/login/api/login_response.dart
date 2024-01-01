import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResponse {
  String? userId = "";
  String? grantType = "";
  String? accessToken = "";
  String? refreshToken = "";

  LoginResponse(
      {this.userId, this.grantType, this.accessToken, this.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
