import 'package:dio/dio.dart';
import 'package:photo_card_flutter/feature/account/api/account_repository.dart';

import '../../../global/api/api_client.dart';
import '../../../global/api/response_entity.dart';
import '../../../global/service/dio_exception_handler.dart';
import '../api/password_edit_request.dart';

class PasswordEditService {
  late final AccountRepository repository;
  final ApiClient apiClient = ApiClient();

  PasswordEditService() {
    repository = AccountRepository(apiClient.createDio());
  }

  Future<ResponseEntity> changePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      final result = await repository.savePassword(PasswordEditRequest(
          currentPassword: currentPassword, newPassword: newPassword));
      return result;
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
      return ResponseEntity();
    }
  }
}
