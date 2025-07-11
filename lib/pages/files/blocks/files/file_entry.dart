import 'package:exdock_backoffice/pages/files/blocks/files/files.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:flutter/material.dart';

class FileEntry extends StatefulWidget {
  const FileEntry({
    super.key,
    required this.file,
    required this.changeAttributeMap,
  });

  final EngineFile file;
  final MapNotifier changeAttributeMap;

  @override
  State<FileEntry> createState() => _FileEntryState();
}

class _FileEntryState extends State<FileEntry> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    Icon fileIcon;

    switch (widget.file.extension.toLowerCase()) {
      case 'pdf':
        fileIcon = const Icon(Icons.picture_as_pdf);
        break;
      case 'jpg':
      case 'avif':
      case 'webp':
      case 'jpeg':
      case 'png':
        fileIcon = const Icon(Icons.image);
        break;
      case 'txt':
        fileIcon = const Icon(Icons.text_fields);
        break;
      default:
        fileIcon = const Icon(Icons.folder);
    }

    Color boxColor = Colors.white;

    if (isHovered) {
      fileIcon = Icon(
        fileIcon.icon,
        color: Colors.blue,
      );
      boxColor = Colors.blue.withValues(alpha: 0.1);
    } else {
      fileIcon = Icon(
        fileIcon.icon,
        color: Colors.grey,
      );
      boxColor = Colors.white;
    }

    return InkWell(
        onHover: (bool isHovered) {
          setState(() {
            this.isHovered = isHovered;
          });
        },
        onTap: () {
          final String originalValue =
              widget.changeAttributeMap.value["path"] ?? "";
          final String extensionString = widget.file.extension != "folder"
              ? ".${widget.file.extension}"
              : "";
          String newValue =
              "$originalValue%2F${widget.file.fileName}$extensionString";

          if (originalValue.isEmpty) {
            newValue = "$originalValue${widget.file.fileName}$extensionString";
          }
          widget.changeAttributeMap
              .updateEntry("path", originalValue, newValue);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  fileIcon,
                  const SizedBox(width: 8),
                  Text(widget.file.fileName),
                ],
              ),
              if (widget.file.fileSize > 0)
                Text(
                  "${widget.file.fileSize} KB",
                  style: const TextStyle(color: Colors.grey),
                ),
            ],
          ),
        ));
  }
}
