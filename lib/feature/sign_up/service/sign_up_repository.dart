import 'package:dio/dio.dart';
import 'package:photo_card_flutter/feature/sign_up/model/sign_up_request.dart';

import '../../../global/api/api_client.dart';

class SignUpRepository {
  ApiClient apiClient = ApiClient();

  Future<void> signUpApi(SignUpRequest signUpRequest) async {
    await apiClient.postHTTP("/member", signUpRequest.toJson());
  }

  Future<bool> validIdApi(String id) async {
    Map<String, String> queryParameters = {"id": id};

    Future<Response?> result =
        apiClient.getHTTP("/user-id/check", queryParameters);

    // TODO
    return true;
  }

  Future<String> getPhoneNumberVerifyCode(String phoneNumber) async {
    Map<String, String> queryParameters = {"number": phoneNumber};

    Future<Response?> result =
        apiClient.getHTTP("/auth/phone", queryParameters);

    // TODO
    return "";
  }

  Future<void> verifyPhoneNumber(String phoneNumber, String code) async {
    Map<String, String> data = {
      "phone_number": phoneNumber,
      "phone_auth_code": code
    };

    await apiClient.postHTTP("/auth/phone", data);

    // TODO
  }

  Future<bool> validEmailApi(String email) async {
    Map<String, String> queryParameters = {"email": email};

    Future<Response?> result =
        apiClient.getHTTP("/email/check", queryParameters);

    // TODO
    return true;
  }

  Future<String> getEmailVerifyCode(String email) async {
    Map<String, String> queryParameters = {"email": email};

    Future<Response?> result =
        apiClient.getHTTP("/auth/email", queryParameters);

    // TODO
    return "";
  }

  Future<void> verifyEmail(String email, String code) async {
    Map<String, String> data = {"email": email, "email_auth_code": code};

    await apiClient.postHTTP("/auth/email", data);

    // TODO
  }
}
