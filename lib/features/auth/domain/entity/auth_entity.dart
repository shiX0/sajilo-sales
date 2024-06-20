import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String fname;
  final String lname;
  final String address;
  final String email;
  final String password;

  const AuthEntity({
    this.id,
    required this.fname,
    required this.lname,
    required this.address,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [id, fname, lname, address, email, password];
}
