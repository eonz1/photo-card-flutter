import 'package:json_annotation/json_annotation.dart';

part 'account_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AccountResponse {
  String? phoneNumber = "";
  String? userEmail = "";
  String? nickname = "";

  AccountResponse({this.phoneNumber, this.userEmail, this.nickname});

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResponseToJson(this);
}
