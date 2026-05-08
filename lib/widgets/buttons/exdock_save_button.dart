// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class ExDockSaveButton extends StatefulWidget {
  const ExDockSaveButton({
    super.key,
    this.width = 256,
    this.height = 64,
    required this.somethingToSaveNotifier,
    required this.onPressed,
  });

  final double width;
  final double height;
  final MapNotifier somethingToSaveNotifier;
  final Function() onPressed;

  @override
  State<ExDockSaveButton> createState() => _ExDockSaveButtonState();
}

class _ExDockSaveButtonState extends State<ExDockSaveButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.somethingToSaveNotifier,
      builder: (context, value, child) {
        if (value.isEmpty) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).cardColor,
              boxShadow: kBoxShadowList,
            ),
            child: Center(
              child: Text(
                "nothing to save",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).disabledColor),
              ),
            ),
          );
        }

        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: TextButton(
            onPressed: widget.onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.hovered)) return darkColour;
                  return mainColour;
                },
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            child: Text(
              "save",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).canvasColor),
            ),
          ),
        );
      },
    );
  }
}
