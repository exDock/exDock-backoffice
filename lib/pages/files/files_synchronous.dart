import 'package:exdock_backoffice/pages/files/blocks/generate_block.dart';
import 'package:exdock_backoffice/pages/files/top_bar/top_bar.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:flutter/material.dart';

class FilesSynchronous extends StatefulWidget {
  const FilesSynchronous({
    super.key,
    required this.blocks,
    required this.changeAttributeMap,
  });

  final Map<String, dynamic> blocks;
  final MapNotifier changeAttributeMap;

  @override
  State<FilesSynchronous> createState() => _FilesSynchronousState();
}

class _FilesSynchronousState extends State<FilesSynchronous> {
  String path = "";

  @override
  void initState() {
    widget.changeAttributeMap.addEntry("path", path);
    widget.changeAttributeMap.addListener(() {
      setState(() {
        path = widget.changeAttributeMap.value["path"] ?? "";
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    widget.changeAttributeMap.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TopBar(
          path: path,
          changeAttributeMap: widget.changeAttributeMap,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: ListView(
            children: List<Widget>.generate(
              widget.blocks.length,
              (index) {
                return GenerateBlock(
                  block: widget.blocks.entries.toList()[index],
                  changeAttributeMap: widget.changeAttributeMap,
                );
              },
            ),
          ),
        )
      ].reversed.toList(),
    );
  }
}
