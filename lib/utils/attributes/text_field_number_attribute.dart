// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:exdock_backoffice/widgets/exdock_card.dart';

class TextFieldNumberAttribute extends StatefulWidget {
  const TextFieldNumberAttribute({
    super.key,
    required this.attribute,
    required this.changeAttributeMap,
    this.signed = false,
    this.decimal = false,
  });

  final Map<String, dynamic> attribute;
  final MapNotifier changeAttributeMap;
  final bool signed;
  final bool decimal;

  @override
  State<TextFieldNumberAttribute> createState() =>
      _TextFieldNumberAttributeState();
}

class _TextFieldNumberAttributeState extends State<TextFieldNumberAttribute> {
  final TextEditingController controller = TextEditingController();
  late final TextInputFormatter inputFormatter;
  String lastValidValue = '';

  @override
  void initState() {
    lastValidValue = widget.attribute['current_attribute_value'].toString();
    controller.text = lastValidValue;

    // Initialize the appropriate regex pattern based on properties
    RegExp pattern;
    if (widget.decimal) {
      pattern = widget.signed
          ? RegExp(r'^-?\d*\.?\d*$') // Signed decimal
          : RegExp(r'^\d*\.?\d*$'); // Unsigned decimal
    } else {
      pattern = widget.signed
          ? RegExp(r'^-?\d*$') // Signed integer
          : RegExp(r'^\d*$'); // Unsigned integer
    }

    // Create input formatter using TextInputFormatter.withFunction
    inputFormatter = TextInputFormatter.withFunction(
      (oldValue, newValue) {
        // If the new value matches our pattern or is empty, accept it
        if (pattern.hasMatch(newValue.text) || newValue.text.isEmpty) {
          lastValidValue = newValue.text;
          return newValue;
        }

        // Otherwise, reject the change and keep the last valid value
        return oldValue;
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExdockCard(
      height: 56,
      child: TextField(
        controller: controller,
        inputFormatters: [inputFormatter],
        keyboardType: TextInputType.numberWithOptions(
          signed: widget.signed,
          decimal: widget.decimal,
        ),
        onChanged: (value) {
          final num numValue =
              widget.decimal ? double.parse(value) : int.parse(value);
          if (numValue == widget.attribute["current_attribute_value"]) {
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
        ),
      ),
    );
  }
}
