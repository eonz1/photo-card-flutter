import 'package:dio/dio.dart';
import 'package:photo_card_flutter/global/service/snack_bar_service.dart';

import '../logger.dart';

class DioExceptionHandler {
  static void showExceptionMessage(DioException exception) {
    final snackBarService = SnackBarService();

    _logging(exception);
    snackBarService.showError(
      _getExceptionMessage(exception),
      duration: const Duration(seconds: 1),
    );
  }

  static String _getExceptionMessage(DioException exception) {
    String defaultMessage = '오류가 발생했습니다.';
    Response<dynamic>? response = exception.response;

    if (response == null) {
      return defaultMessage;
    }

    int? statusCode = response.statusCode;
    String message = response.data['result_msg'] ?? defaultMessage;

    return '[$statusCode] $message';
  }

  static void _logging(DioException exception) {
    if (exception.response == null) {
      logger.e('DioException: ${exception.toString()}');
    } else {
      logger.e('DioException: ${exception.response.toString()}');
    }
  }
}
