import 'package:dio/dio.dart';
import 'package:photo_card_flutter/feature/sign_up/api/sign_up_request.dart';
import 'package:photo_card_flutter/feature/sign_up/api/verify_email_request.dart';
import 'package:retrofit/http.dart';

import '../../../global/api/response_entity.dart';

part 'sign_up_repository.g.dart';

@RestApi()
abstract class SignUpRepository {
  factory SignUpRepository(Dio dio, {String baseUrl}) = _SignUpRepository;

  @POST("/member")
  Future<ResponseEntity<dynamic>> signUp(
    @Body() SignUpRequest signUpRequest,
  );

  @GET("/duplication-check/user-id/{id}")
  Future<ResponseEntity<bool>> isDuplicatedId(@Path('id') String id);

  @POST("/auth/email")
  Future<ResponseEntity<String>> getEmailCode(
      @Body() VerifyEmailRequest verifyEmailRequest);

  @GET("/auth/email/{code}")
  Future<ResponseEntity<String>> verifyEmailCode(
      @Path('code') String code, @Query('user_email') String userEmail);
}
