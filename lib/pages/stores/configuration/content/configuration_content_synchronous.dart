// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// Project imports:
import 'package:exdock_backoffice/pages/stores/configuration/content/configuration_save_widget.dart';
import 'package:exdock_backoffice/utils/blocks/generate_block.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class ConfigurationContentSynchronous extends StatefulWidget {
  const ConfigurationContentSynchronous({
    super.key,
    required this.configurationSettings,
  });

  final Map<String, Map<String, dynamic>> configurationSettings;

  @override
  State<ConfigurationContentSynchronous> createState() =>
      _ConfigurationContentSynchronousState();
}

class _ConfigurationContentSynchronousState
    extends State<ConfigurationContentSynchronous> {
  final MapNotifier changeAttributeMap = MapNotifier();

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, Map<String, dynamic>>> configBlocks =
        widget.configurationSettings.entries.toList();

    // This makes room for the SizedBox on the top right
    configBlocks.insert(1, const MapEntry(',', <String, dynamic>{}));

    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: MasonryGridView.count(
            padding: const EdgeInsets.all(24),
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            shrinkWrap: true,
            crossAxisCount: 2,
            itemCount: configBlocks.length,
            itemBuilder: (context, index) {
              if (index == 1) {
                return const SizedBox(height: 114);
              }

              return GenerateBlock(
                block: configBlocks[index],
                changeAttributeMap: changeAttributeMap,
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ConfigurationSaveWidget(
              somethingToSaveNotifier: changeAttributeMap),
        ),
      ],
    );
  }
}
