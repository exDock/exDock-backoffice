// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/product/info/blocks/product_info_card/product_id_data_card.dart';
import 'package:exdock_backoffice/pages/catalog/product/info/blocks/product_info_card/product_info_image_card.dart';
import 'package:exdock_backoffice/pages/catalog/product/info/blocks/product_info_card/product_price_card.dart';
import 'package:exdock_backoffice/pages/catalog/product/info/blocks/standard_block.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

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
    if (block.value["block_type"] == "id_information") {
      return IdDataBlock(
        block: block,
        changeAttributeMap: changeAttributeMap,
      );
    }
    if (block.value["block_type"] == "images") {
      return ProductInfoImageCard(
        block: block,
        changeAttributeMap: changeAttributeMap,
      );
    }
    if (block.value["block_type"] == "product_price") {
      return ProductPriceCard(
        block: block,
        changeAttributeMap: changeAttributeMap,
      );
    }
    return Center(
      child: Text("Block type not recognised: ${block.value["block_type"]}"),
    );
  }
}
