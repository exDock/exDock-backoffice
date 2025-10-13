// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/variables.dart';
import 'package:exdock_backoffice/pages/system/blocks/generate_system_block.dart';
import 'package:exdock_backoffice/pages/system/blocks/system_block.dart';
import 'package:exdock_backoffice/pages/system/top_bar/system_top_bar.dart';
import 'package:exdock_backoffice/utils/HTTP/post_requests.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class SystemSynchronous extends StatelessWidget {
  const SystemSynchronous({
    super.key,
    required this.blocks,
    required this.changeSettingsMap,
  });

  final Map<String, dynamic> blocks;
  final MapNotifier changeSettingsMap;

  @override
  Widget build(BuildContext context) {
    final MapNotifier changeSettingsMap = MapNotifier();
    final List<MapEntry<String, dynamic>> blocksEntriesList =
        blocks.entries.toList();

    void saveValues() async {
      Map<String, dynamic> serverRequestMap = {};
      for (final entry in changeSettingsMap.value.entries) {
        if (entry.value != null) {
          serverRequestMap[entry.key] = entry.value;
        }
      }

      if (serverRequestMap.isNotEmpty) {
        serverRequestMap = settings.saveSettings(serverRequestMap);
        changeSettingsMap.value.clear();

        try {
          final response = await standardPostRequest(
            "/api/v1/system/setSettings",
            jsonEncode(serverRequestMap),
          );

          if (response.statusCode == 200) {
            changeSettingsMap.reset();
          } else {}
        } catch (e) {
          settings.restoreSettings();
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Text(
                      "Incorrect server URL or server not reachable."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
        }
        settings.removeOldSettings();
      }
    }

    return Stack(
      children: [
        SystemTopBar(
          name: "Settings",
          saveNotifier: changeSettingsMap,
          saveValues: saveValues,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: SystemBlock(
            block: List<Widget>.generate(
              blocks.length,
              (index) {
                return GenerateSystemBlock(
                  block: blocksEntriesList[index],
                  changeSettingsMap: changeSettingsMap,
                );
              },
            ),
            changeSettingsMap: changeSettingsMap,
          ),
        )
      ].reversed.toList(),
    );
  }
}
