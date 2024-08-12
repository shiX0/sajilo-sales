import 'package:sajilo_sales/features/customers/domain/entity/customerENtity.dart';

class CustomerState {
  final List<CustomerEntity> customers;
  final bool isLoading;
  final bool hasReachedMax;
  final int page;
  final String error;

  CustomerState(
      {required this.customers,
      required this.isLoading,
      required this.error,
      required this.hasReachedMax,
      required this.page});

  CustomerState copyWith(
      {List<CustomerEntity>? customers,
      bool? isLoading,
      String? error,
      bool? hasReachedMax,
      int? page}) {
    return CustomerState(
        customers: customers ?? this.customers,
        isLoading: isLoading ?? this.isLoading,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        page: page ?? this.page,
        error: error ?? this.error);
  }

  const CustomerState.initial()
      : customers = const [],
        isLoading = false,
        error = '',
        hasReachedMax = false,
        page = 0;
}
