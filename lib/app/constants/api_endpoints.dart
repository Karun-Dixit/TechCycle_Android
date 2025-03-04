class ApiEndpoints {
  ApiEndpoints._();

  // Adjusted timeouts to more reasonable values
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Base URL for API endpoints (matches your backend running on 192.168.10.68:5000)
  static const String baseUrl = "http://172.26.0.43:5000/api/v1/";

  // For iPhone simulator or local testing (commented out)
  // static const String baseUrl = "http://localhost:5000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/register";

  // Base URL for serving uploaded images (matches your backend's static file route)
  static const String imageUrl = "http://172.26.0.43:5000/uploads/";
  static const String uploadImage = "auth/uploadImage";
}
