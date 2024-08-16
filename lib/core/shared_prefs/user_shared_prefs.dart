import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/auth/domain/entity/auth_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userSharedPrefsProvider = Provider<UserSharedPrefs>((ref) {
  return UserSharedPrefs();
});

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;
  // Set user token
  Future<Either<Failure, bool>> setUserToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('token', token);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> setUser(AuthEntity auth) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('firstname', auth.fname);
      await _sharedPreferences.setString('lastname', auth.lname);
      await _sharedPreferences.setString('email', auth.email);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteUser(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('firstname');
      await _sharedPreferences.remove('lastname');
      await _sharedPreferences.remove('email');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  //Return user
  Future<Either<Failure, List<String>>> getUser() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final firstname = _sharedPreferences.getString('firstname');
      final lastname = _sharedPreferences.getString('lastname');
      final email = _sharedPreferences.getString('email');
      return right([firstname!, lastname!, email!]);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get user token
  Future<Either<Failure, String?>> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final token = _sharedPreferences.getString('token');
      return right(token);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete token
  Future<Either<Failure, bool>> deleteUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('token');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}
