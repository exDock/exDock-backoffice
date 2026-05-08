// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:exdock_backoffice/widgets/input/exdock_text_field.dart';

class TextFieldPassword extends StatefulWidget {
  const TextFieldPassword({
    super.key,
    required this.attribute,
    required this.changeAttributeMap,
  });

  final Map<String, dynamic> attribute;
  final MapNotifier changeAttributeMap;

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.attribute['current_attribute_value'] ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExdockTextField(
      controller: controller,
      isPassword: true,
      onChanged: (value) {
        if (value == widget.attribute["current_attribute_value"]) {
          widget.changeAttributeMap.removeEntry(
            widget.attribute["attribute_id"],
          );
          return;
        }
        widget.changeAttributeMap.addEntry(
          widget.attribute["attribute_id"],
          value,
        );
      },
      labelText: widget.attribute["attribute_name"] ??
          widget.attribute["attribute_id"],
    );
  }
}
