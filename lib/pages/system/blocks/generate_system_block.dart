// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/system/blocks/standard_system_block.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class GenerateSystemBlock extends StatelessWidget {
  const GenerateSystemBlock({
    super.key,
    required this.block,
    required this.changeSettingsMap,
  });

  final MapEntry<String, dynamic> block;
  final MapNotifier changeSettingsMap;

  @override
  Widget build(BuildContext context) {
    if (block.value["block_type"] == "standard") {
      return StandardSystemBlock(
        block: block,
        changeSettingsMap: changeSettingsMap,
      );
    }
    return Center(
      child: Text("Block type not recognised: ${block.value["block_type"]}"),
    );
  }
}
