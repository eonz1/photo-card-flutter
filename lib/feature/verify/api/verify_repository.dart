import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../global/api/response_entity.dart';
import 'verify_email_request.dart';

part 'verify_repository.g.dart';

@RestApi()
abstract class VerifyRepository {
  factory VerifyRepository(Dio dio, {String baseUrl}) = _VerifyRepository;

  @POST("/auth/email")
  Future<ResponseEntity<String>> getEmailCode(
      @Body() VerifyEmailRequest verifyEmailRequest);

  @GET("/auth/email/{code}")
  Future<ResponseEntity<String>> verifyEmailCode(
      @Path('code') String code, @Query('user_email') String userEmail);
}
