// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/pages/system/top_bar/system_server_status.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:exdock_backoffice/widgets/buttons/exdock_save_button.dart';

class SystemTopBar extends StatefulWidget {
  const SystemTopBar({
    super.key,
    required this.name,
    required this.saveNotifier,
    required this.saveValues,
  });

  final String name;
  final MapNotifier saveNotifier;
  final Function saveValues;

  @override
  State<SystemTopBar> createState() => _SystemTopBarState();
}

class _SystemTopBarState extends State<SystemTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: darkColour,
        boxShadow: kBoxShadowList,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 35,
          ),
          const SystemServerStatus(),
          const Expanded(
            child: SizedBox(),
          ),
          ExDockSaveButton(
            somethingToSaveNotifier: widget.saveNotifier,
            onPressed: () {
              widget.saveValues();
            },
          ),
          const SizedBox(
            width: 24,
          )
        ],
      ),
    );
  }
}
