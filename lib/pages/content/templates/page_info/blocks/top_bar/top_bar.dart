// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/pages/content/templates/page_info/blocks/top_bar/id_list.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:exdock_backoffice/widgets/buttons/exdock_save_button.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    super.key,
    required this.name,
    required this.saveNotifier,
    required this.saveValues,
  });

  final String name;
  final MapNotifier saveNotifier;
  final Function saveValues;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              widget.name,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IdList(
              saveNotifier: widget.saveNotifier,
            ),
          ),
          const SizedBox(
            width: 36,
          ),
          ExDockSaveButton(
            somethingToSaveNotifier: widget.saveNotifier,
            onPressed: () {
              widget.saveValues();
            },
          ),
          const SizedBox(
            width: 44,
          )
        ],
      ),
    );
  }
}
