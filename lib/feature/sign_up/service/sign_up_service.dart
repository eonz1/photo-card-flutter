import 'package:dio/dio.dart';

import '../../../global/api/api_client.dart';
import '../../../global/api/response_entity.dart';
import '../../../global/service/dio_exception_handler.dart';
import '../../verify/api/verify_email_request.dart';
import '../../verify/api/verify_repository.dart';
import '../api/sign_up_repository.dart';
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
    late final ResponseEntity<String> result;

    try {
      result = await verifyRepository.verifyEmailCode(code, email);
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
    }

    return result.resultCode == 200;
  }

  Future<bool> getEmailVerifyCode(VerifyEmailRequest verifyEmailRequest) async {
    final result = await verifyRepository.getEmailCode(verifyEmailRequest);

    return result.resultCode == 201;
  }
}
