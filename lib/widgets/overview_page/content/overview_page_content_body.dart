// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/utils/id_set_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/columns/overview_page_column.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/overview_page_content_body_synchronous.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/retrieve_overview_page_pages.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/pagination/page_notifier.dart';

class OverviewPageContentBody extends StatelessWidget {
  const OverviewPageContentBody({
    super.key,
    required this.columnsToRetrieve,
    required this.getPages,
    required this.filters,
    required this.tableWidth,
    required this.allIds,
    required this.selectedIds,
    required this.pageNotifier,
  });

  final List<OverviewPageColumnData> columnsToRetrieve;
  final RetrieveOverviewPagePages getPages;
  final FilterNotifier filters;
  final double tableWidth;
  final Set<String> allIds;
  final IdSetNotifier selectedIds;
  final PageNotifier pageNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pageNotifier,
      builder: (context, value, child) => FutureBuilder(
        future: getPages.getOverviewPagePage(value + 1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            return OverviewPageContentBodySynchronous(
              page: snapshot.data!,
              tableWidth: tableWidth,
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("an error occurred: ${snapshot.error.toString()}"),
            );
          }

          // TODO: replace with exdock page loading widget once available on main
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
