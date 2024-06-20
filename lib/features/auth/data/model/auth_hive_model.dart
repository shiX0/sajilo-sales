import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sajilo_sales/app/constants/hive_table_constant.dart';
import 'package:sajilo_sales/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String fname;

  @HiveField(2)
  final String lname;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String password;

  // Constructor
  AuthHiveModel({
    String? id,
    required this.fname,
    required this.lname,
    required this.address,
    required this.email,
    required this.password,
  }) : id = id ?? const Uuid().v4();

  // empty constructor
  AuthHiveModel.empty()
      : this(
          id: '',
          fname: '',
          lname: '',
          address: '',
          email: '',
          password: '',
        );

  // Convert Hive Object to Entity
  AuthEntity toEntity() => AuthEntity(
        id: id,
        fname: fname,
        lname: lname,
        address: address,
        email: email,
        password: password,
      );

  // Convert Entity to Hive Object
  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
        id: const Uuid().v4(),
        fname: entity.fname,
        lname: entity.lname,
        address: entity.address,
        email: entity.email,
        password: entity.password,
      );

  // Convert Entity List to Hive List
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'id: $id, fname: $fname, lname: $lname,address: $address, email: $email, password: $password';
  }
}
