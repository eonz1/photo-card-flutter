import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:photo_card_flutter/feature/login/api/login_response.dart';
import 'package:photo_card_flutter/global/api/response_entity.dart';

import '../../../global/api/api_client.dart';
import '../../../global/service/dio_exception_handler.dart';
import '../api/login_repository.dart';
import '../api/login_request.dart';

class LoginService {
  late final LoginRepository repository;
  final ApiClient apiClient = ApiClient();

  var logger = Logger();

  LoginService() {
    repository = LoginRepository(apiClient.createDio());
  }

  Future<bool> login({required String id, required String password}) async {
    final request = LoginRequest(userId: id, password: password);

    try {
      ResponseEntity<LoginResponse> response = await repository.login(request);

      final FlutterSecureStorage secureStorage = FlutterSecureStorage();
      await secureStorage.write(key: 'userId', value: response.result!.userId!);
      await secureStorage.write(
          key: 'grantType', value: response.result!.grantType!);
      await secureStorage.write(
          key: 'accessToken', value: response.result!.accessToken!);
      await secureStorage.write(
          key: 'refreshToken', value: response.result!.refreshToken!);

      return true;
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
      return false;
    }
  }
}
