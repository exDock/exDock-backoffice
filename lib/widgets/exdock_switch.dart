// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_switch/flutter_switch.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';

class ExDockSwitch extends StatefulWidget {
  const ExDockSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.isLong = false,
  });

  final bool value;
  final Function(bool) onChanged;
  final bool isLong;

  @override
  State<ExDockSwitch> createState() => _ExDockSwitchState();
}

class _ExDockSwitchState extends State<ExDockSwitch> {
  late bool value = widget.value;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 5,
              color: Color(0x50000000),
            ),
          ],
        ),
        child: FlutterSwitch(
          value: value,
          onToggle: (newValue) {
            widget.onChanged(newValue);
            setState(() {
              value = newValue;
            });
          },
          activeColor: mainColour,
          activeToggleColor: Colors.white,
          inactiveColor: Theme.of(context).cardColor,
          inactiveToggleColor: darkColour,
          width: widget.isLong ? 88 : 44,
          height: 24,
          toggleSize: 12,
        ),
      ),
    );
  }
}
