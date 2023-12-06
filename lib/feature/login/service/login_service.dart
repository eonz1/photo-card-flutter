import 'package:logger/logger.dart';
import 'package:photo_card_flutter/feature/login/api/login_response.dart';
import 'package:photo_card_flutter/global/api/response_entity.dart';

import '../../../global/api/api_client.dart';
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

    ResponseEntity<LoginResponse> response = await repository.login(request);

    return response.status == "success" ? true : false;
  }
}
