import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileResponse {
  String? phoneNumber = "";
  String? userEmail = "";
  String? nickname = "";

  ProfileResponse({this.phoneNumber, this.userEmail, this.nickname});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
