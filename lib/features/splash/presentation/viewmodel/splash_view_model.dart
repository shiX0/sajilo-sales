import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/common/provider/internet_check.dart';
import 'package:sajilo_sales/core/shared_prefs/user_shared_prefs.dart';
import 'package:sajilo_sales/features/splash/presentation/navigator/splash_navigator.dart';

enum SplashState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
  noInternet
}

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, SplashState>(
        (ref) => SplashViewModel(
              navigator: ref.read(splashViewNavigatorProvider),
              userSharedPrefs: ref.read(userSharedPrefsProvider),
              connectivityStatus: ref.watch(connectivityStatusProvider),
            ));

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel({
    required this.navigator,
    required this.userSharedPrefs,
    required this.connectivityStatus,
  }) : super(SplashState.initial) {
    // Check connectivity and login status initially
    checkAndHandleConnectivity();
  }

  final SplashViewNavigator navigator;
  final UserSharedPrefs userSharedPrefs;
  final ConnectivityStatus connectivityStatus;

  void checkAndHandleConnectivity() {
    if (connectivityStatus == ConnectivityStatus.isConnected) {
      checkLoginStatus();
    } else if (connectivityStatus == ConnectivityStatus.isDisconnected) {
      if (mounted) {
        state = SplashState.noInternet;
      }
    }
  }

  Future<void> checkLoginStatus() async {
    if (state == SplashState.loading) return; // Avoid redundant calls
    if (!mounted) return; // Ensure notifier is still mounted

    state = SplashState.loading;

    try {
      // wait for 2 seconds to show the splash screen
      await Future.delayed(const Duration(seconds: 2));
      final result = await userSharedPrefs.getUserToken();
      if (!mounted) return; // Ensure notifier is still mounted

      result.fold(
        (l) {
          if (mounted) {
            state = SplashState.unauthenticated;
            navigator.openLoginView();
          }
        },
        (r) {
          debugPrint('User token retrieved: $r');
          if (mounted && r != null) {
            state = SplashState.authenticated;
            navigator.openHomeView();
          } else {
            state = SplashState.unauthenticated;
            navigator.openLoginView();
          }
        },
      );
    } catch (e) {
      if (mounted) {
        state = SplashState.error;
        navigator.openLoginView();
      }
      debugPrint('Error retrieving user token: $e');
    }
  }
}
