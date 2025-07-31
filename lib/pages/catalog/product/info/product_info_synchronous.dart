// Flutter imports:
// Project imports:
import 'package:exdock_backoffice/pages/catalog/product/info/blocks/generate_block.dart';
import 'package:exdock_backoffice/pages/catalog/product/info/blocks/product_info_block.dart';
import 'package:exdock_backoffice/pages/catalog/product/info/top_bar/top_bar.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:flutter/material.dart';

class ProductInfoSynchronous extends StatelessWidget {
  const ProductInfoSynchronous({
    super.key,
    required this.blocks,
    required this.changeAttributeMap,
  });

  final Map<String, dynamic> blocks;
  final MapNotifier changeAttributeMap;

  @override
  Widget build(BuildContext context) {
    final MapNotifier changeAttributeMap = MapNotifier();
    final List<MapEntry<String, dynamic>> blocksEntriesList =
        blocks.entries.toList();

    saveValues() {
      changeAttributeMap.reset();
      // TODO: Change data in the backend
    }

    return Stack(
      children: [
        TopBar(
          name: "Product Name",
          saveNotifier: changeAttributeMap,
          saveValues: saveValues,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: ProductInfoBlock(
            block: List<Widget>.generate(
              blocks.length,
              (index) {
                return GenerateBlock(
                  block: blocksEntriesList[index],
                  changeAttributeMap: changeAttributeMap,
                );
              },
            ),
            changeAttributeMap: changeAttributeMap,
          ),
        )
      ].reversed.toList(),
    );
  }
}
