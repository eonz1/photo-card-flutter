import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../global/api/response_entity.dart';
import 'password_edit_request.dart';

part 'password_edit_repository.g.dart';

@RestApi()
abstract class PasswordEditRepository {
  factory PasswordEditRepository(Dio dio, {String baseUrl}) =
      _PasswordEditRepository;

  @POST("/member/password")
  Future<ResponseEntity> changePassword(
      @Body() PasswordEditRequest passwordEditRequest);
}
