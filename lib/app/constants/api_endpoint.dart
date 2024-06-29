class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:5000/api/";

  // ====================== Auth Routes ======================
  static const String login = "user/login";

  static const String register = "user/register";
  static const String imgUrl = "http://10.0.2.2:5000/";
//Products
  static const String getProduct = "product/pagination";

  static const int limit = 7;
}
