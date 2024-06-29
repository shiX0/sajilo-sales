
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/constants/api_endpoint.dart';
import 'package:sajilo_sales/core/Networking/remote/http_service.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/core/shared_prefs/user_shared_prefs.dart';
import 'package:sajilo_sales/features/auth/data/model/auth_api_model.dart';
import 'package:sajilo_sales/features/auth/domain/entity/auth_entity.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
      authApiModel: ref.read(authApiModelProvider),
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class AuthRemoteDataSource {
  final Dio dio;
  final AuthApiModel authApiModel;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource(
      {required this.dio,
      required this.authApiModel,
      required this.userSharedPrefs});

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      Response response = await dio.post(ApiEndpoints.register,
          data: (authApiModel.fromEntity(user).toJson()));
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> loginUser(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        // retrieve token
        String token = response.data["token"];
        await userSharedPrefs.setUserToken(token);
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
