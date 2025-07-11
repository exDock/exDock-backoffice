// Flutter imports:
// Project imports:
import 'package:exdock_backoffice/pages/catalog/product/info/blocks/standard_block.dart';
import 'package:exdock_backoffice/pages/files/blocks/files/files.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:flutter/material.dart';

class GenerateBlock extends StatelessWidget {
  const GenerateBlock({
    super.key,
    required this.block,
    required this.changeAttributeMap,
  });

  final MapEntry<String, dynamic> block;
  final MapNotifier changeAttributeMap;

  @override
  Widget build(BuildContext context) {
    if (block.value["block_type"] == "standard") {
      return StandardBlock(
        block: block,
        changeAttributeMap: changeAttributeMap,
      );
    }
    if (block.value["block_type"] == "files") {
      return Files(
        block: block,
        changeAttributeMap: changeAttributeMap,
      );
    }
    return Center(
      child: Text("Block type not recognised: ${block.value["block_type"]}"),
    );
  }
}
