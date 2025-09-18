// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/utils/id_set_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/columns/overview_page_column.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/overview_page_row_cell.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/overview_page_row_cell_string.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/visible_columns_notifier.dart';

class OverviewPageRow extends StatefulWidget {
  const OverviewPageRow({
    super.key,
    required this.id,
    required this.name,
    required this.visibleColumns,
    required this.columnValues,
    required this.allIds,
    required this.selectedIds,
    this.onSelect,
  });

  final String id;
  final String name;

  /// All the columns that are visible in the table
  final VisibleColumnsNotifier visibleColumns;

  /// All column values | {key: value}
  final Map<String, dynamic> columnValues;

  final Set<String> allIds;
  final IdSetNotifier selectedIds;

  final Function()? onSelect;

  @override
  State<OverviewPageRow> createState() => _OverviewPageRowState();
}

class _OverviewPageRowState extends State<OverviewPageRow> {
  bool isSelected = false;

  @override
  void initState() {
    widget.allIds.add(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double contentWidth =
        225; // Initial width: 50 (selectAll) + 75 (id) + 100 (name)
    for (final OverviewPageColumnData column in widget.visibleColumns.value) {
      contentWidth += column.width;
    }

    final Widget child = Container(
      width: contentWidth,
      constraints: const BoxConstraints(minHeight: 50, maxHeight: 150),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: darkColour.withAlpha(50),
            width: 1,
          ),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            OverviewPageRowCell(
              cellValue: ValueListenableBuilder(
                valueListenable: widget.selectedIds,
                builder: (context, set, child) => Checkbox(
                  value: widget.selectedIds.value.contains(widget.id),
                  onChanged: (value) {
                    value ??= false;
                    if (value) {
                      try {
                        widget.selectedIds.addId(widget.id);
                      } catch (_) {
                        print(
                            "widget.selectedIds.allIds: ${widget.selectedIds.allIds}");
                      }
                    } else {
                      widget.selectedIds.removeId(widget.id);
                    }
                  },
                ),
              ),
              width: 50,
            ),
            OverviewPageRowCellString(
              cellValue: widget.id,
              width: 75,
            ),
            OverviewPageRowCellString(
              cellValue: widget.name,
              width: 100,
            ),
            ...widget.visibleColumns.value.asMap().entries.map((entry) {
              final int index = entry.key;
              final OverviewPageColumnData column = entry.value;
              return OverviewPageRowCellString(
                cellValue: widget.columnValues[column.columnKey],
                width: column.width,
                isLast: index == widget.visibleColumns.value.length - 1,
              );
            }),
          ],
        ),
      ),
    );

    if (widget.onSelect != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            widget.onSelect!();
          },
          child: child,
        ),
      );
    }

    return child;
  }
}
