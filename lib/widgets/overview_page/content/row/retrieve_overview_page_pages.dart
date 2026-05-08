// Project imports:
import 'package:exdock_backoffice/utils/id_set_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/overview_page_page.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/overview_page_row.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/columns_notifier.dart';
import 'package:exdock_backoffice/widgets/pagination/page_notifier.dart';

class RetrieveOverviewPagePages {
  RetrieveOverviewPagePages({
    required this.getRows,
    required this.filters,
    required this.allIds,
    required this.selectedIds,
    required this.pageNotifier,
    required this.columns,
    this.pageSize = 10, // TODO: Add this default values to the configuration
    this.currentPage = 0,
    this.cacheForwards =
        0, // TODO: Add this default values to the configuration
    this.cacheBackwards =
        0, // TODO: Add this default values to the configuration
  }) {
    for (int i = 1; i < currentPage; i++) {
      pages.add(null);
    }
  }

  final Future<List<OverviewPageRow>> Function(
    FilterNotifier filters,
    ColumnsNotifier columns,
    Set<String> allIds,
    IdSetNotifier selectedIds,
    PageNotifier pageNotifier,
    bool updateColumns,
  ) getRows;
  final FilterNotifier filters;
  final Set<String> allIds;
  final IdSetNotifier selectedIds;
  final PageNotifier pageNotifier;

  final int pageSize;
  int currentPage;
  final ColumnsNotifier columns;
  final int cacheForwards;
  final int cacheBackwards;
  final List<OverviewPagePage?> pages = [];

  Future<OverviewPagePage> getOverviewPagePage(
    int pageNumber, {
    bool strict = true,
  }) async {
    if (pages.length >= pageNumber && pages[pageNumber - 1] != null) {
      return pages[pageNumber - 1]!;
    }

    final List<OverviewPageRow> rows = await getRows(
      filters,
      columns,
      allIds,
      selectedIds,
      pageNotifier,
      columns.value.isEmpty ? true : false,
    );
    final OverviewPagePage overviewPagePage = OverviewPagePage(
      pageNumber: pageNumber,
      rows: rows,
      getRows: () {
        return getRows(
          filters,
          columns,
          allIds,
          selectedIds,
          pageNotifier,
          false,
        );
      },
    );

    if (pages.length <= pageNumber) {
      pages.add(overviewPagePage);
    } else {
      pages[pageNumber - 1] = overviewPagePage;
    }

    if (!strict && overviewPagePage.rows.isEmpty && pageNumber > 1) {
      return await getOverviewPagePage(pageNumber - 1, strict: false);
    }

    for (int i = 0; i < cacheForwards; i++) {
      if (pages.length > pageNumber + i && pages[pageNumber + i] == null) {
        cachePage(pageNumber + i);
      }
    }

    for (int i = 0; i < cacheBackwards; i++) {
      if (pageNumber - i > 0 && pages[pageNumber - i] == null) {
        cachePage(pageNumber - i);
      }
    }

    return overviewPagePage;
  }

  Future<OverviewPagePage> cachePage(int pageNumber) async {
    return pages[pageNumber - 1] = await getOverviewPagePage(pageNumber);
  }
}
