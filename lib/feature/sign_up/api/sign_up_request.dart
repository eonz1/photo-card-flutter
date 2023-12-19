import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SignUpRequest {
  String? userId = "";
  String? password = "";
  String? phoneNumber = "";
  String? userEmail = "";

  SignUpRequest({this.userId, this.password, this.phoneNumber, this.userEmail});

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}
