// Project imports:

class NotAuthenticatedException implements Exception {
  final String message;
  NotAuthenticatedException(this.message);
}
