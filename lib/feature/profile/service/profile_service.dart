import 'package:dio/dio.dart';
import 'package:photo_card_flutter/feature/profile/api/profile_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global/api/api_client.dart';
import '../../../global/api/response_entity.dart';
import '../../../global/service/dio_exception_handler.dart';
import '../api/profile_repository.dart';
import '../api/profile_response.dart';

class ProfileService {
  late final ProfileRepository repository;
  final ApiClient apiClient = ApiClient();

  ProfileService() {
    repository = ProfileRepository(apiClient.createDio());
  }

  Future<ProfileResponse> getProfile() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      ResponseEntity<ProfileResponse> response = await repository.getProfile();
      return response.result!;
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
      return ProfileResponse();
    }
  }

  // TODO: 응답값 확인하기
  Future<void> saveProfile(
      {required String userEmail, required String nickname}) async {
    try {
      await repository.saveProfile(
          ProfileRequest(photo: "", userEmail: userEmail, nickname: nickname));
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
    }
  }
}
