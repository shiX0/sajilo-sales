import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sajilo_sales/app/navigator_key/navigator_key.dart';
import 'package:sajilo_sales/app/themes/theme_data.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/auth/domain/usecases/auth_usecase.dart';
import 'package:sajilo_sales/features/auth/presentation/navigator/login_navigator.dart';
import 'package:sajilo_sales/features/auth/presentation/navigator/register_navigator.dart';
import 'package:sajilo_sales/features/auth/presentation/view/login_view.dart';
import 'package:sajilo_sales/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../test/unit_test/auth_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;

  setUp(
    () {
      mockAuthUsecase = MockAuthUseCase();
      // mockLoginViewNavigator = MockLoginViewNavigator();
    },
  );
  testWidgets('login test with valid username and password', (tester) async {
    // Arrange
    const correctUsername = 'Shishir';
    const correctPassword = 'Shishir123';

    when(mockAuthUsecase.loginAccount(any, any)).thenAnswer((invocation) {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          username == correctUsername && password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid Credentials')));
    });

    // Act
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
              ref.read(loginViewNavigatorProvider),
              mockAuthUsecase,
              ref.read(registerViewNavigatorProvider),
            ),
          )
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Student Management',
          theme: getApplicationTheme(true),
          home: LoginView(),
        ),
      ),
    );

    // Slow down the test
    await tester
        .pumpAndSettle(const Duration(seconds: 2)); // Adds a 2-second delay

    // Assert
    await tester.enterText(find.byType(TextField).at(0), 'Shishir');

    await tester.enterText(find.byType(TextField).at(1), 'Shishir123');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle(const Duration(
        seconds: 2)); // Delay before settling after tapping the button

    // Check if DashboardView is displayed after login
    expect(find.text("Total:"), findsOneWidget);
  });
  testWidgets('login test with invalid username and password', (tester) async {
    // Arrange
    const correctUsername = 'Shishir';
    const correctPassword = 'Shishir123';

    when(mockAuthUsecase.loginAccount(any, any)).thenAnswer((invocation) {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          username == correctUsername && password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid Credentials')));
    });

    // Act
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
              ref.read(loginViewNavigatorProvider),
              mockAuthUsecase,
              ref.read(registerViewNavigatorProvider),
            ),
          )
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Student Management',
          theme: getApplicationTheme(true),
          home: LoginView(),
        ),
      ),
    );

    // Slow down the test
    await tester
        .pumpAndSettle(const Duration(seconds: 2)); // Adds a 2-second delay

    // Assert
    await tester.enterText(find.byType(TextField).at(0), 'shishir');
    await tester.enterText(find.byType(TextField).at(1), 'Shishishisirr123');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle(const Duration(
        seconds: 2)); // Delay before settling after tapping the button

    // Check if DashboardView is displayed after login
    expect(find.text("Total:"), findsOneWidget);
  });
  testWidgets(
      'test to check if it navigates to register when clicked on regiser',
      (tester) async {
    // Arrange
    const correctUsername = 'Shishir';
    const correctPassword = 'Shishir123';

    when(mockAuthUsecase.loginAccount(any, any)).thenAnswer((invocation) {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          username == correctUsername && password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid Credentials')));
    });

    // Act
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
              ref.read(loginViewNavigatorProvider),
              mockAuthUsecase,
              ref.read(registerViewNavigatorProvider),
            ),
          )
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Student Management',
          theme: getApplicationTheme(true),
          home: LoginView(),
        ),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 2));
    // // GestureDetector(
    //                   onTap: () {
    //                     ref
    //                         .read(authViewModelProvider.notifier)
    //                         .openRegisterView();
    //                   },
    //                   child: const Text(
    //                     'Register?',
    //                     style: TextStyle(color: Colors.grey),
    //                   ),
    //                 ),
    // tap on this
    await tester.tap(find.text('Register?'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    // Check if RegisterView is displayed after clicking on Register
    expect(find.widgetWithText(Text, "Login?"), findsOneWidget);
  });
}
