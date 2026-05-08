// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:exdock_backoffice/widgets/exdock_card.dart';

class TextFieldPriceAttribute extends StatefulWidget {
  const TextFieldPriceAttribute({
    super.key,
    required this.attribute,
    required this.changeAttributeMap,
  });

  final Map<String, dynamic> attribute;
  final MapNotifier changeAttributeMap;

  @override
  State<TextFieldPriceAttribute> createState() =>
      _TextFieldPriceAttributeState();
}

class _TextFieldPriceAttributeState extends State<TextFieldPriceAttribute> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.attribute['current_attribute_value'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExdockCard(
      height: 56,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'^(\d+)?\.?\d{0,2}'),
          ),
        ],
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
        style: const TextStyle(fontSize: 14, height: 1.5),
        decoration: InputDecoration(
          labelText: widget.attribute["attribute_name"] ??
              widget.attribute["attribute_id"],
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Colors.blue,
          prefixText: "€ ",
        ),
      ),
    );
  }
}
