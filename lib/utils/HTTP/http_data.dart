class HttpData {
  final int statusCode;
  final String? responseBody;
  final String? type;

  HttpData({
    required this.statusCode,
    required this.responseBody,
    this.type,
  });
}
