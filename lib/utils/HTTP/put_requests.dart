// Dart imports:
import 'dart:io';

// Project imports:
import 'package:exdock_backoffice/globals/variables.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/HTTP/login_requests.dart';
import 'package:exdock_backoffice/utils/authentication/authentication_data.dart';
// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

Future<HttpData> standardPutRequest(String endpoint, String body) async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  int statusCode;
  String responseBody = "";
  String? accessToken = await storage.read(key: "access_token");
  final String? refreshToken = await storage.read(key: "refresh_token");
  final String baseUrl = settings.getSetting("base_url");

  final Uri uri = Uri.parse("$baseUrl$endpoint");
  if (accessToken == null) {
    throw NotAuthenticatedException("No access token found");
  }

  if (JwtDecoder.isExpired(accessToken)) {
    if (refreshToken == null) {
      return HttpData(statusCode: 401, responseBody: null);
    }

    if (JwtDecoder.isExpired(refreshToken)) {
      throw NotAuthenticatedException("Refresh token expired");
    }

    accessToken = await refreshTokens(refreshToken);
  }

  try {
    final http.Response response = await http.put(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      body: body,
    );

    statusCode = response.statusCode;
    responseBody = String.fromCharCodes(response.bodyBytes);
  } catch (error) {
    throw Exception("Error making PUT request: $error");
  }

  return HttpData(statusCode: statusCode, responseBody: responseBody);
}
