import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_route_constants.dart';

class ApiClient {
  Dio createDio() {
    final options = createDioOptions();
    final dio = Dio(options);
    addInterceptors(dio);

    return dio;
  }

  BaseOptions createDioOptions() {
    return BaseOptions(
      baseUrl:
          "${ApiRouteConstants.getBaseUrl()}${ApiRouteConstants.basePath}/",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
  }

  void addInterceptors(Dio dio) {
    dio.interceptors.add(createInterceptor());
    dio.interceptors.add(createDioLogger());
  }

  Interceptor createInterceptor() {
    onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
      final isLoginRequest =
          options.path == '/login' && options.method == 'POST';

      final isSignUpRequest =
          options.path == '/member' && options.method == 'POST';

      final isDuplicationCheck = options.path.contains('duplication-check');

      if (!isLoginRequest && !isSignUpRequest && !isDuplicationCheck) {
        await setAuthorizationToken(options);
      }

      if (options.contentType == null) {
        final dynamic data = options.data;
        final String? contentType;
        if (data is FormData) {
          contentType = Headers.multipartFormDataContentType;
        } else if (data is Map) {
          contentType = Headers.formUrlEncodedContentType;
        } else if (data is String) {
          contentType = Headers.jsonContentType;
        } else {
          contentType = null;
        }
        options.contentType = contentType;
      }

      handler.next(options);
    }

    onError(DioException err, ErrorInterceptorHandler handler) async {
      final isLoginRequest = err.requestOptions.path == '/login' &&
          err.requestOptions.method == 'POST';

      final isSignUpRequest = err.requestOptions.path == '/member' &&
          err.requestOptions.method == 'POST';

      final isUserIdDuplicationCheck =
          err.requestOptions.path.contains('/duplication-check') &&
              err.requestOptions.method == 'POST';

      if (isSignUpRequest ||
          isLoginRequest ||
          isUserIdDuplicationCheck ||
          err.response?.statusCode != 401) {
        return handler.next(err);
      }

      // TODO: 토큰 재발행 api 호출

      final options = err.requestOptions;
      await setAuthorizationToken(options);

      try {
        final dio = Dio();
        dio.interceptors.add(createDioLogger());
        final response = await dio.fetch(options);
        return handler.resolve(response);
      } on DioException catch (error) {
        return handler.reject(error);
      }
    }

    return InterceptorsWrapper(onRequest: onRequest, onError: onError);
  }

  Interceptor createDioLogger() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    );
  }

  setAuthorizationToken(RequestOptions options) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken') ?? '';

    options.headers['authorization'] = 'Bearer ${token}';
  }
}
