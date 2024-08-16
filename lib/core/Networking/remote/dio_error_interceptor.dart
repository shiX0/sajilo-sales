import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/navigator/navigator.dart';
import 'package:sajilo_sales/core/shared_prefs/user_shared_prefs.dart';
import 'package:sajilo_sales/features/auth/presentation/navigator/login_navigator.dart';
import 'package:sajilo_sales/features/auth/presentation/view/login_view.dart';
import 'package:sajilo_sales/features/splash/presentation/viewmodel/splash_view_model.dart';

class DioErrorInterceptor extends Interceptor {
  final Ref _ref;

  DioErrorInterceptor(this._ref);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    DioException newError;

    if (err.response != null) {
      newError = _handleResponseError(err);
    } else {
      newError = _handleConnectionError(err);
    }

    handler.next(newError);
  }

  DioException _handleResponseError(DioException err) {
    final statusCode = err.response?.statusCode;
    if (statusCode == null) return err;

    if (statusCode == 401) {
      return _handleUnauthorizedError(err);
    } else if (statusCode >= 400) {
      return _handleServerError(err);
    }

    return err;
  }

  DioException _handleUnauthorizedError(DioException err) {
    _ref.read(userSharedPrefsProvider).deleteUserToken();
    return DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      error: 'Unauthorized',
      type: err.type,
    );
  }

  DioException _handleServerError(DioException err) {
    return DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      error: err.response?.data['message'] ??
          err.response?.statusMessage ??
          'Server error',
      type: err.type,
    );
  }

  DioException _handleConnectionError(DioException err) {
    return DioException(
      requestOptions: err.requestOptions,
      error: 'Connection error',
      type: err.type,
    );
  }
}
