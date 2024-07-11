import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/auth/domain/entity/auth_entity.dart';
import 'package:sajilo_sales/features/auth/domain/repository/auth_repository.dart';

final authUseCaseProvider = Provider((ref) {
  return AuthUseCase(ref.read(authRepositoryProvider));
});

class AuthUseCase {
  final IAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<Failure, bool>> registerAccount(AuthEntity? user) async {
    return await _authRepository.registerAccount(user!);
  }

  Future<Either<Failure, bool>> loginAccount(
      String? username, String? password) async {
    return await _authRepository.loginAccount(username!, password!);
  }
}
