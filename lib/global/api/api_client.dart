import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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

      final isVerifyEmail = options.path.contains('/auth/email');

      if (!isLoginRequest &&
          !isSignUpRequest &&
          !isDuplicationCheck &&
          !isVerifyEmail) {
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
      final isLoginRequest = err.requestOptions.path == '/login';

      final isSignUpRequest = err.requestOptions.path == '/member' &&
          err.requestOptions.method == 'POST';

      final isDuplicationCheck =
          err.requestOptions.path.contains('/duplication-check');

      final isVerifyEmail = err.requestOptions.path.contains('/auth/email');

      if (isSignUpRequest ||
          isLoginRequest ||
          isDuplicationCheck ||
          isVerifyEmail ||
          err.response?.statusCode != 401) {
        return handler.next(err);
      }

      final FlutterSecureStorage secureStorage = FlutterSecureStorage();
      String accessToken = await secureStorage.read(key: 'accessToken') ?? '';
      String refreshToken = await secureStorage.read(key: 'refreshToken') ?? '';

      try {
        final dio = Dio();
        final result = await dio.post(
            "${ApiRouteConstants.getBaseUrl()}${ApiRouteConstants.basePath}/reissue",
            options: Options(headers: {
              "AccessToken": accessToken,
              "RefreshToken": refreshToken
            }));

        await secureStorage.write(
            key: 'accessToken', value: result.data["result"]["access_token"]);
        await secureStorage.write(
            key: 'refreshToken', value: result.data["result"]["refresh_token"]);

        final options = err.requestOptions;
        await setAuthorizationToken(options);

        dio.interceptors.add(createDioLogger());

        // 요청 재전송
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
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String token = await secureStorage.read(key: 'accessToken') ?? '';
    String grantType = await secureStorage.read(key: 'grantType') ?? '';

    options.headers['authorization'] = '$grantType $token';
  }
}
