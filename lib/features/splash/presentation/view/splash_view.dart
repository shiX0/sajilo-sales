import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/features/splash/presentation/viewmodel/splash_view_model.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(splashViewModelProvider.notifier).checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(splashViewModelProvider);

    return Scaffold(
      body: Center(
        child: _buildContent(state),
      ),
    );
  }

  Widget _buildContent(SplashState state) {
    switch (state) {
      case SplashState.initial:
      case SplashState.loading:
        return const CircularProgressIndicator();
      case SplashState.authenticated:
      case SplashState.unauthenticated:
        return const SizedBox.shrink(); // The navigator will handle routing
      case SplashState.error:
        return const Text('An error occurred. Please try again.');
      case SplashState.noInternet:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                    'No internet connection. Please check your connection and try again.'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(splashViewModelProvider.notifier)
                    .checkAndHandleConnectivity();
              },
              child: const Text('Retry'),
            ),
          ],
        );
    }
  }
}
