// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// Project imports:
import 'package:exdock_backoffice/globals/variables.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/authentication/authentication_data.dart';

Future<HttpData> loginRequest(String email, String password) async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  int statusCode;
  final String baseUrl = settings.getSetting<String>("base_url");

  final Uri uri = Uri.parse("$baseUrl/api/v1/token");
  try {
    final http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {"email": email, "password": password},
      ),
    );

    statusCode = response.statusCode;

    if (statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic> tokens = jsonDecode(data["tokens"]);
      final String accessToken = tokens["access_token"];
      final String refreshToken = tokens["refresh_token"];

      await storage.write(key: "access_token", value: accessToken);
      await storage.write(key: "refresh_token", value: refreshToken);
    }
  } catch (error) {
    throw Exception("Error making login request: $error");
  }

  return HttpData(statusCode: statusCode, responseBody: null);
}

Future<String> refreshTokens(String refreshToken) async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  final String baseUrl = settings.getSetting<String>("base_url");
  final Uri uri = Uri.parse("$baseUrl/api/v1/refresh");
  try {
    final http.Response response = await http.post(
      uri,
      headers: {"content-type": "application/json"},
      body: jsonEncode(
        {"refresh_token": refreshToken},
      ),
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    await storage.write(key: "access_token", value: data["access_token"]);

    return data["access_token"];
  } catch (_) {
    throw NotAuthenticatedException("Failed to refresh tokens");
  }
}
