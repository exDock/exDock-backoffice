// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class PageTreeItem extends StatefulWidget {
  const PageTreeItem({
    super.key,
    required this.templateName,
    required this.changeAttributeMap,
    required this.templates,
    required this.updateTemplatesCallback,
  });

  final String templateName;
  final MapNotifier changeAttributeMap;
  final List<String> templates;
  final Function updateTemplatesCallback;

  @override
  State<PageTreeItem> createState() => _PageTreeItemState();
}

class _PageTreeItemState extends State<PageTreeItem> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final String oldValue = widget.templateName;
    final TextEditingController _controller =
        TextEditingController(text: widget.templateName);

    if (isEditing) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: kBoxShadowList,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                final List<String> updatedTemplates =
                    List<String>.from(widget.templates);
                updatedTemplates.remove(oldValue);
                widget.updateTemplatesCallback(
                  widget.templates,
                  updatedTemplates,
                );
              },
              child: const Icon(Icons.delete, size: 20.0),
            ),
            const SizedBox(width: 12.0),
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    final List<String> updatedTemplates =
                        List<String>.from(widget.templates);
                    final int oldIndex = updatedTemplates.indexOf(oldValue);
                    updatedTemplates.removeAt(oldIndex);
                    updatedTemplates.insert(oldIndex, _controller.text);
                    widget.updateTemplatesCallback(
                      widget.templates,
                      updatedTemplates,
                    );
                    isEditing = !isEditing;
                  },
                );
              },
              child: const Icon(Icons.check, size: 20.0),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: TextField(
                autofocus: true,
                controller: _controller,
                onSubmitted: (value) {
                  setState(
                    () {
                      isEditing = false;
                      if (value.isNotEmpty && value != oldValue) {
                        final List<String> updatedTemplates =
                            List<String>.from(widget.templates);
                        final int index = updatedTemplates.indexOf(oldValue);
                        if (index != -1) {
                          updatedTemplates[index] = value;
                          widget.updateTemplatesCallback(
                            widget.templates,
                            updatedTemplates,
                          );
                        }
                      }
                    },
                  );
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: kBoxShadowList,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              final List<String> updatedTemplates =
                  List<String>.from(widget.templates);
              updatedTemplates.remove(oldValue);
              widget.updateTemplatesCallback(
                widget.templates,
                updatedTemplates,
              );
            },
            child: const Icon(Icons.delete, size: 20.0),
          ),
          const SizedBox(width: 12.0),
          GestureDetector(
            onTap: () {
              setState(
                () {
                  isEditing = !isEditing;
                },
              );
            },
            child: const Icon(Icons.edit, size: 20.0),
          ),
          const SizedBox(width: 12.0),
          Text(
            widget.templateName,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
