// ignore: unused_import
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/auth/domain/entity/auth_entity.dart';
import 'package:sajilo_sales/features/auth/domain/usecases/auth_usecase.dart';
import 'package:sajilo_sales/features/auth/presentation/navigator/login_navigator.dart';
import 'package:sajilo_sales/features/auth/presentation/navigator/register_navigator.dart';
import 'package:sajilo_sales/features/auth/presentation/viewmodel/auth_view_model.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
  MockSpec<RegisterViewNavigator>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthUseCase mockAuthUsecase;
  late LoginViewNavigator mockLoginNavigator;
  late RegisterViewNavigator mockRegisterNavigator;

  late ProviderContainer container;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase();
    mockLoginNavigator = MockLoginViewNavigator();
    mockRegisterNavigator = MockRegisterViewNavigator();
    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith((ref) => AuthViewModel(
          mockLoginNavigator, mockAuthUsecase, mockRegisterNavigator))
    ]);
  });

  test('check for the inital state in Auth state', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
  });

  test('login test with valid username and password', () async {
    // Arrange
    const correctUsername = 'Shishir';
    const correctPassword = 'Shishir123';

    when(mockAuthUsecase.loginAccount(any, any)).thenAnswer((invocation) {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          username == correctUsername && password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid Credentails')));
    });
    // Act
    await container
        .read(authViewModelProvider.notifier)
        .loginStudent('Shishir', 'Shishir123');
    final authState = container.read(authViewModelProvider);
    // Assert
    expect(authState.error, isNull);
  });

  test("register with user credientials", () async {
    when(mockAuthUsecase.registerAccount(any))
        .thenAnswer((_) => Future.value(const Right(true)));

    const AuthEntity user = AuthEntity(
        fname: "Shishir",
        lname: "Sharma",
        address: "Nepal",
        email: "test@softwarica.edu.np",
        password: "Shishir123");
    await container.read(authViewModelProvider.notifier).registerAccount(user);
    final authState = container.read(authViewModelProvider);
    // Assert
    expect(authState.error, isNull);
  });

  tearDown(() {
    container.dispose();
  });
}
