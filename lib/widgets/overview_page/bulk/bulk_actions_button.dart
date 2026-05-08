// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/buttons/exdock_button.dart';
import 'package:exdock_backoffice/widgets/overview_page/bulk/bulk_action.dart';
import 'package:exdock_backoffice/widgets/overview_page/bulk/bulk_action_pop_up.dart';

class BulkActionsButton extends StatelessWidget {
  const BulkActionsButton({super.key, required this.bulkActions});

  final List<BulkAction> bulkActions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 171,
      child: Card(
        margin: EdgeInsets.zero,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            onChanged: (value) {
              if (value == null) return;

              showPopupWindow(context, childFun: (pop) {
                return BulkActionPopUp(
                  key: GlobalKey(),
                  bulkAction: value,
                  pop: pop,
                );
              });
            },
            customButton: const ExdockButton(
              label: "bulk actions",
              icon: Icons.bolt_rounded,
            ),
            buttonStyleData: ButtonStyleData(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            )),
            dropdownStyleData: DropdownStyleData(
              offset: const Offset(0, -4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            isExpanded: true,
            isDense: true,
            items: List<DropdownMenuItem<BulkAction>>.generate(
              bulkActions.length,
              (index) => DropdownMenuItem(
                value: bulkActions[index],
                child: Text(bulkActions[index].name),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
