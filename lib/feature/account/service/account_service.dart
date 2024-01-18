import 'package:dio/dio.dart';
import 'package:photo_card_flutter/feature/account/api/email_edit_request.dart';
import 'package:photo_card_flutter/feature/account/api/nickname_edit_response.dart';
import 'package:photo_card_flutter/feature/verify/api/verify_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global/api/api_client.dart';
import '../../../global/api/response_entity.dart';
import '../../../global/service/dio_exception_handler.dart';
import '../../verify/api/verify_email_request.dart';
import '../api/account_repository.dart';
import '../api/nickname_edit_request.dart';
import '../api/account_response.dart';

class AccountService {
  late final AccountRepository accountRepository;
  late final VerifyRepository verifyRepository;
  final ApiClient apiClient = ApiClient();

  AccountService() {
    accountRepository = AccountRepository(apiClient.createDio());
    verifyRepository = VerifyRepository(apiClient.createDio());
  }

  Future<AccountResponse> getProfile() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      ResponseEntity<AccountResponse> response =
          await accountRepository.getAccountInfo();
      return response.result!;
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
      return AccountResponse();
    }
  }

  Future<NicknameEditResponse> saveNickname({required String nickname}) async {
    final request = NicknameEditRequest(nickname: nickname);

    try {
      final response = await accountRepository.saveNickname(request);

      if (response.resultCode == 204) {
        return response.result!;
      } else {
        return NicknameEditResponse();
      }
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
      return NicknameEditResponse();
    }
  }

  Future<bool> changeEmail(
      {required String email, required String code}) async {
    final request = EmailEditRequest(userEmail: email, authNumber: code);

    try {
      final response = await accountRepository.saveEmail(request);
      return response.resultCode == 204;
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
      return false;
    }
  }

  Future<bool> getEmailVerifyCode(VerifyEmailRequest verifyEmailRequest) async {
    try {
      final result = await verifyRepository.getEmailCode(verifyEmailRequest);
      return result.resultCode == 201;
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
      return false;
    }
  }

  Future<bool> verifyEmailVerifyCode(
      {required String code, required String email}) async {
    try {
      final result = await verifyRepository.verifyEmailCode(code, email);
      return result.resultCode == 200;
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
      return false;
    }
  }
}
