import 'package:json_annotation/json_annotation.dart';

part 'withdraw_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WithdrawRequest {
  String? password = "";

  WithdrawRequest({this.password});

  factory WithdrawRequest.fromJson(Map<String, dynamic> json) =>
      _$WithdrawRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawRequestToJson(this);
}
