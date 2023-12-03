import 'package:dio/dio.dart';
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
      setAuthorizationToken(options);

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
      final isLoginRequest = err.requestOptions.path == '/api/v1/login' &&
          err.requestOptions.method == 'POST';

      if (isLoginRequest || err.response?.statusCode != 401) {
        return handler.next(err);
      }

      // TODO: 토큰 재발행 api 호출

      final options = err.requestOptions;
      setAuthorizationToken(options);

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

  setAuthorizationToken(RequestOptions options) {
    // TODO
    // options.headers['authorization'] = 'Bearer ' + token;
  }
}
