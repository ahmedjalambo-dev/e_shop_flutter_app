class ApiConstants {
  static const String baseUrl = 'https://accessories-eshop.runasp.net/';
  static const String login = 'api/auth/login';
  static const String signup = 'api/auth/register';
  static const String verifyEmail = 'api/auth/verify-email';
  static const String validateOtp = 'api/auth/validate-otp';
  static const String resendOtp = 'api/auth/resend-otp';
  static const String forgotPassword = 'api/auth/forgot-password';
  static const String resetPassword = 'api/auth/reset-password';
  static const String refreshToken = 'api/auth/refresh-token';
  static const String categories = 'api/categories';
  static const String products = 'api/products';
  static const String cartItems = 'api/cart/items';
  static const String cart = 'api/cart';
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = 'unknownError';
  static const String timeoutError = 'timeoutError';
  static const String defaultError = 'defaultError';
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
