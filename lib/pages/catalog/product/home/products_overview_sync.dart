import 'package:exdock_backoffice/utils/id_set_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/bulk/bulk_action.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/retrieve_overview_page_pages.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_setup/filter_setup.dart';
import 'package:exdock_backoffice/widgets/overview_page/overview_page.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/columns_notifier.dart';
import 'package:exdock_backoffice/widgets/pagination/page_notifier.dart';
import 'package:flutter/material.dart';

class ProductsOverviewSync extends StatefulWidget {
  const ProductsOverviewSync({
    super.key,
    required this.allIds,
    required this.columns,
    required this.visibleColumns,
    required this.getPages,
    required this.bulkActions,
    required this.filters,
    required this.pageNotifier,
    this.getFilters,
  });

  final ColumnsNotifier columns;
  final ColumnsNotifier visibleColumns;
  final Set<String> allIds;
  final RetrieveOverviewPagePages getPages;
  final List<BulkAction> bulkActions;
  final FilterNotifier filters;
  final PageNotifier pageNotifier;
  final Future<List<FilterSetupData>> Function()? getFilters;

  @override
  State<ProductsOverviewSync> createState() => _ProductsOverviewSyncState();
}

class _ProductsOverviewSyncState extends State<ProductsOverviewSync> {
  late final selectedIds = IdSetNotifier(widget.allIds);

  @override
  Widget build(BuildContext context) {
    return OverviewPage(
      columns: widget.columns,
      visibleColumns: widget.visibleColumns,
      getPages: widget.getPages,
      bulkActions: widget.bulkActions,
      filters: widget.filters,
      allIds: widget.allIds,
      selectedIds: selectedIds,
      pageNotifier: widget.pageNotifier,
      getFilters: widget.getFilters,
    );
  }
}
