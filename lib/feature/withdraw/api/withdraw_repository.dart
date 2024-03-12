import 'package:dio/dio.dart';
import 'package:photo_card_flutter/feature/withdraw/api/withdraw_request.dart';
import 'package:retrofit/http.dart';

import '../../../global/api/response_entity.dart';

part 'withdraw_repository.g.dart';

@RestApi()
abstract class WithdrawRepository {
  factory WithdrawRepository(Dio dio, {String baseUrl}) = _WithdrawRepository;

  @DELETE("/member")
  Future<ResponseEntity<dynamic>> withdraw(
      @Body() WithdrawRequest withdrawRequest);
}
