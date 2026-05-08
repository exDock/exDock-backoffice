// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_widget_close_button.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/types/filter.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
    required this.filter,
    required this.allFilters,
  });

  final FilterData filter;
  final FilterNotifier allFilters;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(300),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Text("${filter.name}: ${filter.displayValue}"),
            const SizedBox(width: 12),
            FilterWidgetCloseButton(
              onPressed: () {
                allFilters.removeFilter(filter);
              },
            ),
          ],
        ),
      ),
    );
  }
}
