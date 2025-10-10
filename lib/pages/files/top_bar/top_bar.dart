// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/pages/files/top_bar/file_breadcrumb_item.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    super.key,
    required this.path,
    required this.changeAttributeMap,
  });

  final String path;
  final MapNotifier changeAttributeMap;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    final List<String> pathSplit =
        widget.changeAttributeMap.value["path"].split("%2F");
    final List<BreadCrumbItem> breadcrumbs = [];

    breadcrumbs.add(
      BreadCrumbItem(
        content: FileBreadCrumbItem(
          title: "Home",
          pathSplit: const [],
          changeAttributeMap: widget.changeAttributeMap,
        ),
      ),
    );

    for (final pathString in pathSplit) {
      breadcrumbs.add(
        BreadCrumbItem(
          content: FileBreadCrumbItem(
            title: pathString,
            pathSplit: pathSplit,
            changeAttributeMap: widget.changeAttributeMap,
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
