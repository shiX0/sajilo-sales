import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/common/custom_snackbar.dart';
import 'package:sajilo_sales/features/customers/domain/entity/customerENtity.dart';
import 'package:sajilo_sales/features/customers/domain/usecases/customer_repository_usecase.dart';
import 'package:sajilo_sales/features/customers/presentation/state/customer_state.dart';

final customerViewModelProvider =
    StateNotifierProvider<CustomerViewModel, CustomerState>(
        (ref) => CustomerViewModel(ref.read(customerUsecaseProvider)));

class CustomerViewModel extends StateNotifier<CustomerState> {
  final CustomerUsecase _customerRepositoryUsecase;
  CustomerViewModel(this._customerRepositoryUsecase)
      : super(const CustomerState.initial());

  Future<void> getCustomers() async {
    if (state.isLoading || state.hasReachedMax) return;
    state = state.copyWith(isLoading: true);
    final page = state.page + 1;

    final result = await _customerRepositoryUsecase.getAllCustomer(page);

    result.fold(
      (failure) {
        showMySnackBar(message: failure.error, color: Colors.red);
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
          hasReachedMax: true,
        );
      },
      (data) {
        if (data.isEmpty) {
          state = state.copyWith(hasReachedMax: true, isLoading: false);
        } else {
          state = state.copyWith(
            isLoading: false,
            customers: [...state.customers, ...data],
            page: page,
            error: null,
          );
        }
      },
    );
  }

  Future<void> refreshCustomers() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, customers: []);
    final result = await _customerRepositoryUsecase.getAllCustomer(1);
    result.fold(
      (failure) {
        showMySnackBar(message: failure.error, color: Colors.red);
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
          hasReachedMax: true,
        );
      },
      (data) {
        if (data.isEmpty) {
          state = state.copyWith(hasReachedMax: true, isLoading: false);
        } else {
          state = state.copyWith(
            isLoading: false,
            customers: data,
            page: 1,
            error: null,
            hasReachedMax: false,
          );
        }
      },
    );
  }

  Future<void> addCustomer(CustomerEntity customer) async {
    state = state.copyWith(isLoading: true);
    final result = await _customerRepositoryUsecase.addCustomer(customer);
    result.fold(
      (failure) {
        showMySnackBar(message: failure.error, color: Colors.red);
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
      },
      (data) {
        state = state.copyWith(
          isLoading: false,
          error: null,
        );
      },
    );
    refreshCustomers();
  }

  Future<void> updateCustomer(CustomerEntity customer) async {
    state = state.copyWith(isLoading: true);
    final result = await _customerRepositoryUsecase.updateCustomer(customer);
    result.fold(
      (failure) {
        showMySnackBar(message: failure.error, color: Colors.red);
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
      },
      (data) {
        showMySnackBar(
            message: "Customer updated successfully", color: Colors.green);
        state = state.copyWith(
          isLoading: false,
          error: null,
        );
      },
    );
    refreshCustomers();
  }

  Future<void> deleteCustomer(String id) async {
    state = state.copyWith(isLoading: true);
    final result = await _customerRepositoryUsecase.deleteCustomer(id);
    result.fold(
      (failure) {
        showMySnackBar(message: failure.error, color: Colors.red);
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
      },
      (data) {
        showMySnackBar(
            message: "Customer deleted successfully", color: Colors.green);
        state = state.copyWith(
          isLoading: false,
          error: null,
        );
      },
    );
    refreshCustomers();
  }
}
