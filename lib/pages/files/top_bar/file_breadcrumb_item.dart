// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/router/router.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class FileBreadCrumbItem extends StatefulWidget {
  const FileBreadCrumbItem({
    super.key,
    required this.title,
    required this.pathSplit,
    required this.changeAttributeMap,
  });

  final String title;
  final List<String> pathSplit;
  final MapNotifier changeAttributeMap;

  @override
  State<FileBreadCrumbItem> createState() => _FileBreadCrumbItemState();
}

class _FileBreadCrumbItemState extends State<FileBreadCrumbItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (bool isHoveredLocal) {
        setState(() {
          isHovered = isHoveredLocal;
        });
      },
      onTap: () {
        final String path = widget.changeAttributeMap.value["path"] as String;
        final String newPath = widget.pathSplit
            .sublist(0, widget.pathSplit.indexOf(widget.title) + 1)
            .join("%2F");

        if (widget.pathSplit.isEmpty) {
          router.push("/files");
        } else if (path != newPath) {
          router.push("/files?path=$newPath");
        }
      },
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: 25,
          color: isHovered ? Colors.blueGrey : Colors.white,
        ),
      ),
    );
  }
}
