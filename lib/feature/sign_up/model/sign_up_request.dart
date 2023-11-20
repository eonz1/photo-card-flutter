import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_request.freezed.dart';
part 'sign_up_request.g.dart';

@freezed
class SignUpRequest with _$SignUpRequest {
  const factory SignUpRequest({
    required String user_id,
    required String password,
    required String phone_number,
    required String user_email,
  }) = _SignUpRequest;

  factory SignUpRequest.fromJson(Map<String, Object?> json)
  => _$SignUpRequestFromJson(json);
}