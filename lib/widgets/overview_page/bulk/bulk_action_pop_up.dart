// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kumi_popup_window/kumi_popup_window.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/buttons/exdock_button.dart';
import 'package:exdock_backoffice/widgets/overview_page/bulk/bulk_action.dart';

class BulkActionPopUp extends StatelessWidget {
  const BulkActionPopUp({
    super.key,
    required this.bulkAction,
    required this.pop,
  });

  final BulkAction bulkAction;
  final KumiPopupWindow pop;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            bulkAction.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          ...List.generate(
            bulkAction.userParameterCollection.parameters.length,
            (index) {
              return bulkAction.userParameterCollection.parameters[index]
                  .getInputWidget();
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: Row(
              children: [
                Flexible(
                  child: ExdockButton(
                    label: "CANCEL",
                    onPressed: () {
                      pop.dismiss(context);
                    },
                  ),
                ),
                const SizedBox(width: 24),
                Flexible(
                  child: ExdockButton(
                    label: "EXECUTE",
                    onPressed: () {
                      bulkAction.execute(
                        onFailure: () {
                          // This check is necessary for if execute() is async
                          if (context.mounted) {
                            pop.dismiss(context);
                          }
                        },
                        onSuccess: () {
                          // This check is necessary for if execute() is async
                          if (context.mounted) {
                            pop.dismiss(context);
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
