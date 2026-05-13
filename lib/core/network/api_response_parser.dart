/// Helpers for Laravel responses shaped by [ApiResponseTrait]:
/// `{ "status": bool, "message": string, "data": ... }`
class ApiResponseParser {
  ApiResponseParser._();

  /// First validation error string, or [message], or a fallback.
  static String errorMessage(Map result, [String fallback = 'Request failed']) {
    final message = result['message'];
    if (message != null && message.toString().isNotEmpty) {
      final data = result['data'];
      if (data is Map) {
        for (final value in data.values) {
          if (value is List && value.isNotEmpty) {
            return value.first.toString();
          }
          if (value is String && value.isNotEmpty) {
            return value;
          }
        }
      }
      return message.toString();
    }
    return fallback;
  }

  static bool isSuccess(Map result) => result['status'] == true;
}
