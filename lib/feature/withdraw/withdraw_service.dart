import 'package:dio/dio.dart';

import '../../global/api/api_client.dart';
import '../../global/service/dio_exception_handler.dart';
import 'api/withdraw_repository.dart';
import 'api/withdraw_request.dart';

class WithdrawService {
  late final WithdrawRepository withdrawRepository;
  final ApiClient apiClient = ApiClient();

  WithdrawService() {
    withdrawRepository = WithdrawRepository(apiClient.createDio());
  }

  Future<bool> withdraw(WithdrawRequest withdrawRequest) async {
    try {
      final response = await withdrawRepository.withdraw(withdrawRequest);
      return response.resultCode == 200;
    } on DioException catch (exception) {
      DioExceptionHandler.showExceptionMessage(exception);
      return false;
    }
  }
}
