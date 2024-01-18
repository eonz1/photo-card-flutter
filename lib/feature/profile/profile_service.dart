import 'package:dio/dio.dart';
import 'package:photo_card_flutter/feature/logout/api/logout_repository.dart';

import '../../global/api/api_client.dart';
import '../../global/service/dio_exception_handler.dart';

class ProfileService {
  late final LogoutRepository logoutRepository;
  final ApiClient apiClient = ApiClient();

  ProfileService() {
    logoutRepository = LogoutRepository(apiClient.createDio());
  }

  Future<bool> logout() async {
    try {
      final response = await logoutRepository.logout();
      return response.resultCode == 200;
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
      return false;
    }
  }
}
