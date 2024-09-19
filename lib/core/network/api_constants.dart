class ApiErrors {
  static const String badRequestError =
      "Invalid request. Please check your input and try again.";
  static const String noContent = "No content available at the moment.";
  static const String forbiddenError =
      "You don't have permission to access this resource.";
  static const String unauthorizedError =
      "Session expired. Please log in again.";
  static const String notFoundError =
      "The requested resource could not be found.";
  static const String conflictError =
      "Conflict detected. Please resolve any discrepancies.";
  static const String internalServerError =
      "Something went wrong on our end. Please try again later.";
  static const String unknownError =
      "An unknown error occurred. Please try again.";
  static const String timeoutError =
      "The request took too long. Please check your connection and try again.";
  static const String defaultError =
      "An unexpected error occurred. Please try again.";
  static const String cacheError = "There was a problem loading cached data.";
  static const String noInternetError =
      "No internet connection. Please check your connection and try again.";
  static const String loadingMessage = "Loading... Please wait.";
  static const String retryAgainMessage = "Something went wrong. Please retry.";
  static const String ok = "OK";
}
