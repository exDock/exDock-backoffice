// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/content/pages/page_info/blocks/page_block/page_tree.dart';
import 'package:exdock_backoffice/pages/content/pages/page_info/blocks/page_block/page_variables.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class GenerateBlock extends StatelessWidget {
  const GenerateBlock(
      {super.key, required this.block, required this.changeAttributeMap});

  final MapEntry<String, dynamic> block;
  final MapNotifier changeAttributeMap;

  @override
  Widget build(BuildContext context) {
    if (block.value["block_type"] == "page_variables") {
      return PageVariables(
        block: block,
        changeAttributeMap: changeAttributeMap,
      );
    }
    if (block.value["block_type"] == "page_tree") {
      return PageTree(
        block: block,
        changeAttributeMap: changeAttributeMap,
      );
    }
    return Center(
      child: Text("Block type not recognised: ${block.value["block_type"]}"),
    );
  }
}
