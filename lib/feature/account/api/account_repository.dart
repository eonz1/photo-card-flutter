import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../global/api/response_entity.dart';
import 'email_edit_request.dart';
import 'nickname_edit_request.dart';
import 'nickname_edit_response.dart';
import 'account_response.dart';
import 'password_edit_request.dart';

part 'account_repository.g.dart';

@RestApi()
abstract class AccountRepository {
  factory AccountRepository(Dio dio, {String baseUrl}) = _AccountRepository;

  @GET("/member/account")
  Future<ResponseEntity<AccountResponse>> getAccountInfo();

  @PATCH("/member/nickname")
  Future<ResponseEntity<NicknameEditResponse>> saveNickname(
      @Body() NicknameEditRequest request);

  @PATCH("/member/email")
  Future<ResponseEntity> saveEmail(@Body() EmailEditRequest request);

  @PATCH("/member/password")
  Future<ResponseEntity> savePassword(
      @Body() PasswordEditRequest passwordEditRequest);
}
