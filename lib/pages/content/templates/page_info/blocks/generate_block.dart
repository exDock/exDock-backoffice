import 'package:exdock_backoffice/pages/content/templates/page_info/blocks/template_block/template.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:flutter/material.dart';

class GenerateBlock extends StatelessWidget {
  const GenerateBlock(
      {super.key, required this.block, required this.changeAttributeMap});

  final MapEntry<String, dynamic> block;
  final MapNotifier changeAttributeMap;

  @override
  Widget build(BuildContext context) {
    if (block.value["block_type"] == "template") {
      return Template(
        block: block,
        changeAttributeMap: changeAttributeMap,
      );
    }
    return Center(
      child: Text("Block type not recognised: ${block.value["block_type"]}"),
    );
  }
}
