import 'package:dio/dio.dart';
import 'package:photo_card_flutter/global/api/response_entity.dart';
import 'package:retrofit/http.dart';

import 'login_request.dart';
import 'login_response.dart';

part 'login_repository.g.dart';

@RestApi()
abstract class LoginRepository {
  factory LoginRepository(Dio dio, {String baseUrl}) = _LoginRepository;

  @POST("/login")
  Future<ResponseEntity<LoginResponse>> login(
    @Body() LoginRequest loginRequest,
  );
}
