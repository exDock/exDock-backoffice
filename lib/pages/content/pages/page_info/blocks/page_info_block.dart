// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// Project imports:
import 'package:exdock_backoffice/utils/map_notifier.dart';

class PageInfoBlock extends StatefulWidget {
  const PageInfoBlock({
    super.key,
    required this.block,
    required this.changeAttributeMap,
  });

  final List<Widget> block;
  final MapNotifier changeAttributeMap;

  @override
  State<PageInfoBlock> createState() => _PageInfoBlockState();
}

class _PageInfoBlockState extends State<PageInfoBlock> {
  @override
  Widget build(BuildContext context) {
    int count = 2;

    if (widget.block.length < 2) {
      count = 1;
    }

    return MasonryGridView.count(
      padding: const EdgeInsets.all(24),
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      shrinkWrap: true,
      crossAxisCount: count,
      itemCount: widget.block.length,
      itemBuilder: (content, index) {
        return widget.block[index];
      },
    );
  }
}
