import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../global/api/response_entity.dart';

part 'logout_repository.g.dart';

@RestApi()
abstract class LogoutRepository {
  factory LogoutRepository(Dio dio, {String baseUrl}) = _LogoutRepository;

  @POST("/logout")
  Future<ResponseEntity<dynamic>> logout();
}
