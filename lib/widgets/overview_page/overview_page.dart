// Flutter imports:
// Project imports:
import 'package:exdock_backoffice/utils/id_set_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/bulk/bulk_action.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/columns/overview_page_column.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/overview_page_content.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/retrieve_overview_page_pages.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/active_filters.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_setup/filter_setup.dart';
import 'package:exdock_backoffice/widgets/overview_page/overview_page_header.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/columns_notifier.dart';
import 'package:exdock_backoffice/widgets/pagination/page_notifier.dart';
import 'package:flutter/material.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({
    super.key,
    required this.columns,
    required this.visibleColumns,
    required this.getPages,
    this.bulkActions = const [],
    required this.filters,
    this.individualName,
    required this.allIds,
    required this.selectedIds,
    required this.pageNotifier,
    this.getFilters,
    this.newUrl,
  });

  final ColumnsNotifier columns;
  final ColumnsNotifier visibleColumns;
  final RetrieveOverviewPagePages getPages;
  final List<BulkAction> bulkActions;
  final FilterNotifier filters;
  final String? individualName;
  final Set<String> allIds;
  final IdSetNotifier selectedIds;
  final PageNotifier pageNotifier;
  final Future<List<FilterSetupData>> Function()? getFilters;
  final String? newUrl;

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  void initState() {
    super.initState();

    for (final OverviewPageColumnData column in widget.columns.value) {
      if (!widget.visibleColumns.containsColumn(column)) {
        widget.visibleColumns.addColumn(column);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OverviewPageHeader(
          columns: widget.columns,
          visibleColumns: widget.visibleColumns,
          bulkActions: widget.bulkActions,
          filters: widget.filters,
          selectedIds: widget.selectedIds,
          individualName: widget.individualName,
          getFilters: widget.getFilters,
          newUrl: widget.newUrl,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 124, left: 24, right: 24),
          child: SizedBox(
            height: 75,
            child: ActiveFilters(
              filters: widget.filters,
              pageNotifier: widget.pageNotifier,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 199),
          child: OverviewPageContent(
            visibleColumns: widget.visibleColumns,
            getPages: widget.getPages,
            filters: widget.filters,
            allIds: widget.allIds,
            selectedIds: widget.selectedIds,
            pageNotifier: widget.pageNotifier,
          ),
        ),
      ].reversed.toList(),
    );
  }
}
