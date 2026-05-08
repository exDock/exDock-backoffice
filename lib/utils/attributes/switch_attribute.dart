// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:exdock_backoffice/widgets/exdock_switch.dart';

class SwitchAttribute extends StatefulWidget {
  const SwitchAttribute({
    super.key,
    required this.attribute,
    required this.changeAttributeMap,
  });

  final Map<String, dynamic> attribute;
  final MapNotifier changeAttributeMap;

  @override
  State<SwitchAttribute> createState() => _SwitchAttributeState();
}

class _SwitchAttributeState extends State<SwitchAttribute> {
  late bool switchValue = widget.attribute['current_attribute_value'] ?? false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.attribute['attribute_name']),
        const SizedBox(width: 24),
        ExDockSwitch(
          value: switchValue,
          onChanged: (value) {
            switchValue = value;

            if (value == widget.attribute['current_attribute_value']) {
              widget.changeAttributeMap
                  .removeEntry(widget.attribute['attribute_id']);
              return;
            }

            widget.changeAttributeMap
                .addEntry(widget.attribute['attribute_id'], value);
          },
        ),
      ],
    );
  }
}
