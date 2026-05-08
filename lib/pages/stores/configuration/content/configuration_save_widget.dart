// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/styling.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:exdock_backoffice/widgets/buttons/exdock_save_button.dart';

class ConfigurationSaveWidget extends StatelessWidget {
  const ConfigurationSaveWidget({
    super.key,
    required this.somethingToSaveNotifier,
  });

  final MapNotifier somethingToSaveNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        width: (MediaQuery.of(context).size.width - 100 - 250 - 3 * 24) / 2,
        decoration: const BoxDecoration(
          color: darkColour,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(36),
            bottomRight: Radius.circular(12),
          ),
          boxShadow: kBoxShadowList,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: ExDockSaveButton(
                somethingToSaveNotifier: somethingToSaveNotifier,
                onPressed: () {
                  // TODO: Save the configuration
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
