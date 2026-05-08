// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/product/info/blocks/generate_block.dart';
import 'package:exdock_backoffice/utils/blocks/category_edit_content_blocks.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class CategoryEditContentSynchronous extends StatefulWidget {
  const CategoryEditContentSynchronous({
    super.key,
    required this.blocks,
    required this.changeAttributeMap,
  });

  final Map<String, dynamic> blocks;
  final MapNotifier changeAttributeMap;

  @override
  State<CategoryEditContentSynchronous> createState() =>
      _CategoryEditContentSynchronousState();
}

class _CategoryEditContentSynchronousState
    extends State<CategoryEditContentSynchronous> {
  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, dynamic>> blocksEntriesList =
        widget.blocks.entries.toList();
    return CategoryEditContentBlocks(
      blocks: List<Widget>.generate(
        widget.blocks.length,
        (index) {
          return GenerateBlock(
            block: blocksEntriesList[index],
            changeAttributeMap: widget.changeAttributeMap,
          );
        },
      ),
      changeAttributeMap: widget.changeAttributeMap,
    );
  }
}
