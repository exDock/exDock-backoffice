// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/overview_page/content/columns/overview_page_column.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/visible_column_selection.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/columns_notifier.dart';

class VisibleColumnsSelection extends StatelessWidget {
  const VisibleColumnsSelection({
    super.key,
    required this.columns,
    required this.visibleColumns,
  });

  final ColumnsNotifier columns;
  final ColumnsNotifier visibleColumns;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Container(
        width: 1048,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.extent(
            maxCrossAxisExtent: 256,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 16 / 6,
            children: List<Widget>.generate(columns.value.length, (index) {
              return VisibleColumnSelection(
                column: columns.value[index],
                visibleColumns: visibleColumns,
                onToggle: (OverviewPageColumnData column, bool isVisible) {
                  if (isVisible) {
                    visibleColumns.silentAddColumn(column);
                  } else {
                    visibleColumns.silentRemoveColumn(column);
                  }
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
