// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/variables.dart';
import 'package:exdock_backoffice/pages/system/system_synchronous.dart';
import 'package:exdock_backoffice/utils/HTTP/get_request.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class System extends StatefulWidget {
  const System({super.key});

  @override
  State<System> createState() => _SystemState();
}

class _SystemState extends State<System> {
  Future<Map<String, dynamic>> getSystemData() async {
    final HttpData httpData =
        await standardGetRequest("/api/v1/system/getSettings");

    final Map<String, dynamic> backOfficeSettings = {
      "BackOffice Settings": {
        "block_type": "standard",
        "attributes": generateBackOfficeSettings(),
      },
    };

    final Map<String, dynamic> jsonData =
        jsonDecode(httpData.responseBody!) as Map<String, dynamic>;
    jsonData.addAll(backOfficeSettings);

    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSystemData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Placeholder();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return SystemSynchronous(
              blocks: snapshot.data!,
              changeSettingsMap: MapNotifier(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

Map<String, dynamic> generateBackendAttribute(
    String id, String name, String type, dynamic value) {
  return {
    "attribute_id": id,
    "attribute_name": name,
    "attribute_type": type,
    "current_attribute_value": value,
  };
}

List<Map<String, dynamic>> generateBackOfficeSettings() {
  final List<Map<String, dynamic>> backOfficeSettings = [];
  final List<String> settingsKeys = settings.getSettingsKeys();
  for (final String key in settingsKeys) {
    backOfficeSettings.add({
      "attribute_id": key,
      "attribute_name": key.replaceAll("_", " ").capitalize(),
      "attribute_type":
          classToAttribute(settings.getSetting(key).runtimeType.toString()),
      "current_attribute_value": settings.getSetting(key),
    });
  }

  return backOfficeSettings;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

String classToAttribute(String clazz) {
  return switch (clazz) {
    "int" => "number",
    "double" => "number",
    "String" => "text",
    "bool" => "boolean",
    "List<String>" => "list",
    _ => clazz,
  };
}
