import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_request.freezed.dart';
part 'sign_up_request.g.dart';

@freezed
class SignUpRequest with _$SignUpRequest {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SignUpRequest({
    required String userId,
    required String password,
    required String phoneNumber,
    required String userEmail,
  }) = _SignUpRequest;

  factory SignUpRequest.fromJson(Map<String, Object?> json) =>
      _$SignUpRequestFromJson(json);
}
