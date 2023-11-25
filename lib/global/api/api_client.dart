import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_route_constants.dart';

class ApiClient {
  late Dio apiClient;

  ApiClient() {
    Dio dio = createDio();
    apiClient = dio;
  }

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
        } else if (data != null) {
          contentType =
              Headers.textPlainContentType; // Can be removed if unnecessary.
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

      if (isLoginRequest ||
          err.response?.statusCode != 401 ||
          err.response?.data['resultCode'] != 40101) {
        return handler.next(err);
      }

      // TODO: 토큰 재발행 api 호출
      String token = apiClient.get('/api/v1/token') as String;

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

  Future<Response?> getHTTP(
      String path, Map<String, String>? queryParameters) async {
    Response response =
        await apiClient.get(path, queryParameters: queryParameters);
    return response;
  }

  Future<Response?> postHTTP(String path, dynamic data) async {
    Response response = await apiClient.post(path, data: data);
    return response;
  }

  Future<Response?> putHTTP(String path, dynamic data) async {
    Response response = await apiClient.put(path, data: data);
    return response;
  }

  Future<Response?> patchHTTP(String path, dynamic data) async {
    Response response = await apiClient.patch(path, data: data);
    return response;
  }

  Future<Response?> deleteHTTP(String path) async {
    Response response = await apiClient.delete(path);
    return response;
  }
}
