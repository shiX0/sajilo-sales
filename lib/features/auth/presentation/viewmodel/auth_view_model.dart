import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/common/custom_snackbar.dart';
import 'package:sajilo_sales/features/auth/domain/entity/auth_entity.dart';
import 'package:sajilo_sales/features/auth/domain/usecases/auth_usecase.dart';
import 'package:sajilo_sales/features/auth/presentation/navigator/login_navigator.dart';
import 'package:sajilo_sales/features/auth/presentation/navigator/register_navigator.dart';
import 'package:sajilo_sales/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(ref.read(loginViewNavigatorProvider),
      ref.read(authUseCaseProvider), ref.read(registerViewNavigatorProvider)),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.navigator, this.authUseCase, this.registerViewNavigator)
      : super(AuthState.initial());
  final AuthUseCase authUseCase;
  final LoginViewNavigator navigator;
  final RegisterViewNavigator registerViewNavigator;

  Future<void> registerAccount(AuthEntity student) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.registerAccount(student);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        // showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        // showMySnackBar(message: "Successfully registered");
      },
    );
  }

  Future<void> loginAccount(
    String username,
    String password,
  ) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.loginAccount(username, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        // showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        openHomeView();
      },
    );
  }

  void openRegisterView() {
    navigator.openRegisterView();
  }

  void openHomeView() {
    navigator.openHomeView();
  }

  void openLoginView() {
    registerViewNavigator.openLoginView();
  }
}
