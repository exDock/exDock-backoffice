// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/utils/id_set_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/columns/overview_page_column.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/columns/overview_page_column_cell.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/utils/select_all_checkbox.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/columns_notifier.dart';

class OverviewPageContentHeader extends StatelessWidget {
  const OverviewPageContentHeader({
    super.key,
    required this.visibleColumns,
    required this.tableWidth,
    required this.selectedIds,
  });

  final ColumnsNotifier visibleColumns;
  final double tableWidth;
  final IdSetNotifier selectedIds;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tableWidth,
      decoration: const BoxDecoration(
          color: darkColour,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          const SizedBox(width: 1), // compensate for left border
          SizedBox(
            width: 50,
            child: SelectAllCheckbox(selectedIds: selectedIds),
          ),
          const OverviewPageColumnCell(columnName: "ID", width: 75),
          const OverviewPageColumnCell(columnName: "name", width: 100),
          for (final OverviewPageColumnData column in visibleColumns.value)
            OverviewPageColumnCell(
              columnName: column.name,
              columnKey: column.columnKey,
              width: column.width,
            ),
        ],
      ),
    );
  }
}
