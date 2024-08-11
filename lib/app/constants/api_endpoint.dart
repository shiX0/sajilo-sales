class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:5000/api/";

  // ====================== Auth Routes ======================

  static const String imgUrl = "http://10.0.2.2:5000/";
//Products
  static const String getProduct = "product/";
  static const int limit = 7;

  // Auth
  static const String register = "user/register";
  static const String login = "user/login";
  static const String forgotPassword = "user/forgotpassword";
  static const String resetPassword = "user/resetpassword";

  // Customer
  static const String createCustomer = "customer/create";
  static const String getAllCustomers = "customer";
  static const String getCustomerById = "customer/{id}";
  static const String getCustomerAnalytics = "customer/analytics";
  static const String searchCustomer = "customer/search/";
  static const String updateCustomer = "customer/update/{id}";
  static const String deleteCustomer = "customer/delete/{id}";

  // Order
  static const String getAllOrders = "order/";
  static const String getOrderById = "order/{id}";
  static const String getOrderAnalytics = "order/analytics";
  static const String createOrder = "order/create";
  static const String updateOrder = "order/{id}";
  static const String deleteOrder = "order/{id}";

  // Product
  static const String getAllProducts = "product/";
  static const String createProduct = "product/create";
  static const String getProductById = "product/{id}";
  static const String updateProduct = "product/{id}";
  static const String deleteProduct = "product/{id}";

  // Dashboard Metrics
  static const String getMetrics = "metrics/";
}
