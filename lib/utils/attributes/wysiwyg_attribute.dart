// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fleather/fleather.dart';
import 'package:parchment_to_html/parachment_to_html.dart';

// Project imports:
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:exdock_backoffice/widgets/exdock_card.dart';

class WysiwygAttribute extends StatefulWidget {
  const WysiwygAttribute({
    super.key,
    required this.attribute,
    required this.changeAttributeMap,
  });

  final Map<String, dynamic> attribute;
  final MapNotifier changeAttributeMap;

  @override
  State<WysiwygAttribute> createState() => _WysiwygAttributeState();
}

class _WysiwygAttributeState extends State<WysiwygAttribute> {
  // TODO: make raw HTML editable
  late FleatherController controller;
  ParchmentHtmlCodec converter = const ParchmentHtmlCodec();

  @override
  void initState() {
    super.initState();

    // Get the initial HTML value from the attribute
    final String initialHtml =
        widget.attribute['current_attribute_value'] ?? '';

    // Convert HTML to Delta
    final Delta delta = converter.decode(initialHtml);

    // Convert Delta to ParchmentDocument
    final ParchmentDocument document = ParchmentDocument.fromDelta(delta);

    // Initialize the controller
    controller = FleatherController(document: document);

    controller.addListener(() {
      String value = converter
          .encode(controller.document.toDelta())
          .replaceAll("<br><br>", "<br>");

      if (value.endsWith("<br>")) {
        value = value.substring(0, value.length - 4); // Remove last "<br>"
      }

      if (value == widget.attribute['current_attribute_value']) {
        widget.changeAttributeMap.removeEntry(widget.attribute['attribute_id']);
        return;
      }
      widget.changeAttributeMap.addEntry(
        widget.attribute['attribute_id'],
        value,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExdockCard(
      child: Column(
        children: [
          FleatherToolbar.basic(controller: controller),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 75),
              child: FleatherEditor(controller: controller),
            ),
          ),
        ],
      ),
    );
  }
}
