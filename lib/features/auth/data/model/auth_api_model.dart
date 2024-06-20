import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sajilo_sales/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

final authApiModelProvider = Provider<AuthApiModel>((ref) {
  return AuthApiModel.empty();
});

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'firstName')
  final String fname;

  @JsonKey(name: 'lastName')
  final String lname;

  final String address;

  final String email;

  final String? password;

  AuthApiModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.address,
    required this.email,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      fname: fname,
      lname: lname,
      address: address,
      email: email,
      password: password ?? '',
    );
  }

  AuthApiModel.empty()
      : id = '',
        fname = '',
        lname = '',
        address = '',
        email = '',
        password = '';

  AuthApiModel fromEntity(AuthEntity entity) => AuthApiModel(
      fname: entity.fname,
      lname: entity.fname,
      address: entity.address,
      email: entity.email,
      password: entity.password);
}
