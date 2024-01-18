import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:photo_card_flutter/feature/login/api/login_response.dart';
import 'package:photo_card_flutter/global/api/response_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', response.result!.userId!);
      prefs.setString('grantType', response.result!.grantType!);
      prefs.setString('accessToken', response.result!.accessToken!);
      prefs.setString('refreshToken', response.result!.refreshToken!);

      return true;
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
      return false;
    }
  }
}
