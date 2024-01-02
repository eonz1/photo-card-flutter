import 'package:dio/dio.dart';
import 'package:photo_card_flutter/feature/profile/api/password_edit_repository.dart';
import 'package:photo_card_flutter/feature/profile/api/password_edit_request.dart';

import '../../../global/api/api_client.dart';
import '../../../global/api/response_entity.dart';
import '../../../global/service/dio_exception_handler.dart';

class PasswordEditService {
  late final PasswordEditRepository repository;
  final ApiClient apiClient = ApiClient();

  PasswordEditService() {
    repository = PasswordEditRepository(apiClient.createDio());
  }

  Future<ResponseEntity> changePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      final result = await repository.changePassword(PasswordEditRequest(
          currentPassword: currentPassword, newPassword: newPassword));
      return result;
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
      return ResponseEntity();
    }
  }
}
