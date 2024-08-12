import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sajilo_sales/features/customers/domain/entity/customerENtity.dart';

part 'customer_model.g.dart';

final customerModelProvider =
    Provider<CustomerModel>((ref) => const CustomerModel.empty());

@JsonSerializable()
class CustomerModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String address;

  const CustomerModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  const CustomerModel.empty()
      : id = "",
        name = "",
        email = "",
        phone = "",
        address = "";

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  CustomerEntity toEntity(CustomerModel customer) {
    return CustomerEntity(
      id: customer.id,
      name: customer.name,
      email: customer.email,
      phone: customer.phone,
      address: customer.address,
    );
  }

  CustomerModel fromEntity(CustomerEntity customer) {
    return CustomerModel(
      id: customer.id ?? "",
      name: customer.name,
      email: customer.email,
      phone: customer.phone,
      address: customer.address,
    );
  }

  List<CustomerEntity> toEntities(List<CustomerModel> customers) {
    return customers.map((customer) => toEntity(customer)).toList();
  }

  @override
  List<Object?> get props => [name, email, phone, address];
}
