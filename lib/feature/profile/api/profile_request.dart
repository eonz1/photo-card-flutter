import 'package:json_annotation/json_annotation.dart';

part 'profile_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileRequest {
  String? photo = "";
  String? nickname = "";
  String? userEmail = "";

  ProfileRequest({this.photo, this.userEmail, this.nickname});

  factory ProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileRequestToJson(this);
}
