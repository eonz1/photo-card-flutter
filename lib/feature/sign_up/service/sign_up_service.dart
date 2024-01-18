import 'package:dio/dio.dart';
import 'package:photo_card_flutter/feature/sign_up/api/sign_up_repository.dart';
import 'package:photo_card_flutter/feature/verify/api/verify_email_request.dart';
import 'package:photo_card_flutter/feature/verify/api/verify_repository.dart';
import 'package:photo_card_flutter/global/api/response_entity.dart';

import '../../../global/api/api_client.dart';
import '../../../global/service/dio_exception_handler.dart';
import '../api/sign_up_request.dart';

class SignUpService {
  late final SignUpRepository signUpRepository;
  late final VerifyRepository verifyRepository;
  final ApiClient apiClient = ApiClient();

  SignUpService() {
    signUpRepository = SignUpRepository(apiClient.createDio());
    verifyRepository = VerifyRepository(apiClient.createDio());
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
    final result = await verifyRepository.verifyEmailCode(code, email);

    return result.resultCode == 200;
  }

  Future<bool> getEmailVerifyCode(VerifyEmailRequest verifyEmailRequest) async {
    final result = await verifyRepository.getEmailCode(verifyEmailRequest);

    return result.resultCode == 201;
  }
}
