// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/category/category_blocks/category_products_block/category_products_block.dart';
import 'package:exdock_backoffice/pages/catalog/product/info/blocks/standard_block.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class GenerateBlock extends StatelessWidget {
  const GenerateBlock(
      {super.key, required this.block, required this.changeAttributeMap});

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
    if (block.value["block_type"] == "category_products") {
      return CategoryProductsBlock(
        currentProducts: block.value["current_products"],
        changeAttributeMap: changeAttributeMap,
      );
    }
    return Center(
      child: Text("Block type not recognised: ${block.value["block_type"]}"),
    );
  }
}
