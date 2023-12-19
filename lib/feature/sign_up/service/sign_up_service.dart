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

  Future<void> signUp({
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

  Future<void> getEmailVerifyCode(String email) async {
    // TODO
    await signUpRepository.getEmailCode(email);
  }

  Future<bool> verifyEmailCode(VerifyEmailRequest verifyEmailRequest) async {
    // TODO
    final result = await signUpRepository.verifyEmailCode(verifyEmailRequest);

    return true;
  }

  bool isValidEmailFormat(value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}
