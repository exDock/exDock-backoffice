// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';

class UnsavedChangesOverlay extends StatefulWidget {
  const UnsavedChangesOverlay({
    super.key,
    required this.unsavedChangesNotifier,
  });

  final ValueNotifier<bool> unsavedChangesNotifier;

  @override
  State<UnsavedChangesOverlay> createState() => _UnsavedChangesOverlayState();
}

class _UnsavedChangesOverlayState extends State<UnsavedChangesOverlay> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: ValueListenableBuilder(
        valueListenable: widget.unsavedChangesNotifier,
        builder: (context, value, child) {
          if (!value) {
            return const SizedBox();
          }
          return Container(
            height: 36,
            decoration: const BoxDecoration(
              color: darkColour,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
              boxShadow: kBoxShadowList,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "unsaved changes",
                    style: TextStyle(color: Theme.of(context).canvasColor),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
