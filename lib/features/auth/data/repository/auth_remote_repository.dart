import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:sajilo_sales/features/auth/domain/entity/auth_entity.dart';
import 'package:sajilo_sales/features/auth/domain/repository/auth_repository.dart';

final authRemoteRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRemoteRepository(ref.read(authRemoteDataSourceProvider));
});

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);
  @override
  Future<Either<Failure, bool>> loginAccount(String email, String password) {
    return _authRemoteDataSource.loginUser(email, password);
  }

  @override
  Future<Either<Failure, bool>> registerAccount(AuthEntity user) {
    return _authRemoteDataSource.registerUser(user);
  }
}
