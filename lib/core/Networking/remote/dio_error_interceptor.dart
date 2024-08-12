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
    if (err.response != null) {
      _handleResponseError(err);
    } else {
      _handleConnectionError(err);
    }

    super.onError(err, handler);
  }

  void _handleResponseError(DioException err) {
    final statusCode = err.response?.statusCode;
    if (statusCode == null) return;

    if (statusCode == 401) {
      _handleUnauthorizedError(err);
    } else if (statusCode >= 400) {
      _handleServerError(err);
    }
  }

  void _handleUnauthorizedError(DioException err) {
    final newErr = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      error: 'Unauthorized',
      type: err.type,
    );
    _ref.read(userSharedPrefsProvider).deleteUserToken();
    NavigateRoute.popAndPushRoute(LoginView());
    err = newErr;
  }

  void _handleServerError(DioException err) {
    final newErr = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      error: err.response?.data['message'] ??
          err.response?.statusMessage ??
          'Server error',
      type: err.type,
    );
    err = newErr;
  }

  void _handleConnectionError(DioException err) {
    final newErr = DioException(
      requestOptions: err.requestOptions,
      error: 'Connection error',
      type: err.type,
    );
    err = newErr;
  }
}
