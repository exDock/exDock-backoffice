// Flutter imports:
// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    super.key,
    required this.path,
  });

  final String path;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    final List<String> pathSplit = widget.path.split("%2F");
    final List<BreadCrumbItem> breadcrumbs = [];

    for (final pathString in pathSplit) {
      breadcrumbs.add(
        BreadCrumbItem(
          content: Text(
            pathString,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: darkColour,
        boxShadow: kBoxShadowList,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 35,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: BreadCrumb(
              items: breadcrumbs,
              divider: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
