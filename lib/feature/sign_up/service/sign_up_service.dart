import 'package:dio/dio.dart';
import 'package:photo_card_flutter/feature/sign_up/api/sign_up_repository.dart';
import 'package:photo_card_flutter/feature/sign_up/api/verify_email_request.dart';
import 'package:photo_card_flutter/global/api/response_entity.dart';

import '../../../global/api/api_client.dart';
import '../../../global/service/dio_exception_handler.dart';
import '../api/sign_up_request.dart';

class SignUpService {
  late final SignUpRepository signUpRepository;
  final ApiClient apiClient = ApiClient();

  SignUpService() {
    signUpRepository = SignUpRepository(apiClient.createDio());
  }

  Future<ResponseEntity> signUp({
    required String id,
    required String password,
    required String phoneNumber,
    required String email,
  }) async {
    final request = SignUpRequest(
        userId: id,
        password: password,
        phoneNumber: phoneNumber,
        userEmail: email);

    return await signUpRepository.signUp(request);
  }

  Future<bool> isDuplicatedId({required String id}) async {
    late final ResponseEntity<bool> result;

    try {
      result = await signUpRepository.isDuplicatedId(id);
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
    }

    return result.result!;
  }

  Future<bool> verifyEmailVerifyCode(String code, String email) async {
    final result = await signUpRepository.verifyEmailCode(code, email);

    return result.resultCode == 200;
  }

  Future<bool> getEmailVerifyCode(VerifyEmailRequest verifyEmailRequest) async {
    final result = await signUpRepository.getEmailCode(verifyEmailRequest);

    return result.resultCode == 201;
  }

  bool isEmailFormat(value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

  bool isPasswordFormat(value) {
    return RegExp(r"^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$")
        .hasMatch(value);
  }

  bool isIdFormat(value) {
    return RegExp(r"^[a-z0-9]{6,12}$").hasMatch(value);
  }
}
