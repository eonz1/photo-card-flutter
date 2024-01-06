import 'package:dio/dio.dart';
import 'package:photo_card_flutter/feature/profile/api/profile_request.dart';
import 'package:photo_card_flutter/feature/profile/api/profile_response.dart';
import 'package:retrofit/http.dart';

import '../../../global/api/response_entity.dart';

part 'profile_repository.g.dart';

@RestApi()
abstract class ProfileRepository {
  factory ProfileRepository(Dio dio, {String baseUrl}) = _ProfileRepository;

  @GET("/member/account")
  Future<ResponseEntity<ProfileResponse>> getProfile();

  @POST("/profile")
  Future<ResponseEntity> saveProfile(@Body() ProfileRequest profileRequest);
}
