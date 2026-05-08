// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/exdock_switch.dart';

class CategoryEditHeaderSwitches extends StatefulWidget {
  const CategoryEditHeaderSwitches({super.key});

  // TODO: determine necessary input

  @override
  State<CategoryEditHeaderSwitches> createState() =>
      _CategoryEditHeaderSwitchesState();
}

class _CategoryEditHeaderSwitchesState
    extends State<CategoryEditHeaderSwitches> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CategoryEditHeaderSwitch(
            title: "enable category",
            value: true, // TODO: add changing functionality
            onChanged: (value) {},
          ),
          const SizedBox(height: 12),
          CategoryEditHeaderSwitch(
            title: "include in menu",
            value: false, // TODO: aad changing functionality
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}

class CategoryEditHeaderSwitch extends StatelessWidget {
  const CategoryEditHeaderSwitch({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        const SizedBox(width: 12),
        ExDockSwitch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
