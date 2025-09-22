// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/utils/id_set_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/overview_page_content_body.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/overview_page_content_header.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/retrieve_overview_page_pages.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/columns_notifier.dart';
import 'package:exdock_backoffice/widgets/pagination/page_notifier.dart';

class OverviewPageContent extends StatefulWidget {
  const OverviewPageContent({
    super.key,
    required this.visibleColumns,
    required this.getPages,
    required this.filters,
    required this.allIds,
    required this.selectedIds,
    required this.pageNotifier,
  });

  final ColumnsNotifier visibleColumns;
  final RetrieveOverviewPagePages getPages;
  final FilterNotifier filters;
  final Set<String> allIds;
  final IdSetNotifier selectedIds;
  final PageNotifier pageNotifier;

  @override
  State<OverviewPageContent> createState() => _OverviewPageContentState();
}

class _OverviewPageContentState extends State<OverviewPageContent> {
  double getTableWidth() {
    return widget.visibleColumns.value.fold(
      226, // 50 (selectAll) + 75 (id) + 100 (name) + 1 (left table border)
      (previousValue, element) => previousValue + element.width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ValueListenableBuilder(
        valueListenable: widget.visibleColumns,
        builder: (context, value, child) {
          final double tableWidth = getTableWidth();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OverviewPageContentHeader(
                visibleColumns: widget.visibleColumns,
                tableWidth: tableWidth,
                selectedIds: widget.selectedIds,
              ),
              Expanded(
                child: OverviewPageContentBody(
                  // TODO: reconsider if columnsToRetrieve should be the same as visibleColumns
                  columnsToRetrieve: widget.visibleColumns.value,
                  getPages: widget.getPages,
                  filters: widget.filters,
                  tableWidth: tableWidth,
                  allIds: widget.allIds,
                  selectedIds: widget.selectedIds,
                  pageNotifier: widget.pageNotifier,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
