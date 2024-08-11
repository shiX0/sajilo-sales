import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sajilo_sales/app/constants/api_endpoint.dart';
import 'package:sajilo_sales/core/shared_prefs/user_shared_prefs.dart';

final httpServiceProvider = Provider<Dio>(
  (ref) => HttpService(Dio(), ref).dio,
);

class HttpService {
  final Dio _dio;
  final ProviderRef _ref;
  Dio get dio => _dio;

  HttpService(this._dio, this._ref) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final tokenResult =
              await _ref.read(userSharedPrefsProvider).getUserToken();
          tokenResult.fold(
            (failure) => handler.reject(DioException(
              requestOptions: options,
              error: 'Failed to get token',
            )),
            (token) {
              if (token != null) {
                options.headers["Authorization"] = "Bearer $token";
              }
              handler.next(options);
            },
          );
        },
      ))
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: true,
      ))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }

  // For FormData requests
  Dio getFormDataDio() {
    final formDataDio = Dio()
      ..options = _dio.options
      ..options.headers['Content-Type'] = 'multipart/form-data'
      ..interceptors.addAll(_dio.interceptors);
    return formDataDio;
  }
}
