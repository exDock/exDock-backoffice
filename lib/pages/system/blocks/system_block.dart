// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// Project imports:
import 'package:exdock_backoffice/utils/map_notifier.dart';

class SystemBlock extends StatefulWidget {
  const SystemBlock({
    super.key,
    required this.block,
    required this.changeSettingsMap,
  });

  final List<Widget> block;
  final MapNotifier changeSettingsMap;

  @override
  State<SystemBlock> createState() => _SystemBlockState();
}

class _SystemBlockState extends State<SystemBlock> {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.all(24),
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      shrinkWrap: true,
      crossAxisCount: 2,
      itemCount: widget.block.length,
      itemBuilder: (context, index) {
        return widget.block[index];
      },
    );
  }
}
