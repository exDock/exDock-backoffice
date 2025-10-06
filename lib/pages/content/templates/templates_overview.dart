// Flutter imports:

// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/content/pages/bulk_actions/delete_pages_bulk_action.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/HTTP/post_requests.dart';
import 'package:exdock_backoffice/utils/id_set_notifier.dart';
import 'package:exdock_backoffice/utils/user_parameters/text_user_parameter.dart';
import 'package:exdock_backoffice/utils/user_parameters/user_parameter_collection.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/columns/overview_page_column.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/overview_page_row.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/retrieve_overview_page_pages.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_setup/filter_setup.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_setup/filter_setup_type_data.dart';
import 'package:exdock_backoffice/widgets/overview_page/overview_page.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/columns_notifier.dart';
import 'package:exdock_backoffice/widgets/pagination/page_notifier.dart';

class TemplatesOverview extends StatefulWidget {
  const TemplatesOverview({super.key});

  @override
  State<TemplatesOverview> createState() => _PagesOverviewState();
}

class _PagesOverviewState extends State<TemplatesOverview> {
  final ColumnsNotifier visibleColumns = ColumnsNotifier(columns: []);
  Set<String> allIds = {};
  late IdSetNotifier selectedIds = IdSetNotifier(allIds);

  Future<List<OverviewPageColumnData>> getPagesColumns() async {
    return [];
  }

  Future<List<OverviewPageRow>> Function(
    FilterNotifier filters,
    ColumnsNotifier columns,
    Set<String> allIds,
    IdSetNotifier selectedIds,
    PageNotifier pageNotifier,
    bool updateColumns,
  ) getPagesRows() {
    Future<List<OverviewPageRow>> getRows(
      FilterNotifier filters,
      ColumnsNotifier columns,
      Set<String> allIds,
      IdSetNotifier selectedIds,
      PageNotifier pageNotifier,
      bool updateColumns,
    ) async {
      final HttpData httpData = await standardPostRequest(
        "/api/v1/getBlockData",
        jsonEncode(
          {
            "page_name": "templates_overview",
            "address_names": [
              {
                "address": "templatesAll",
                "id": "/home",
              },
            ],
          },
        ),
      );

      final Map<String, dynamic> data =
          jsonDecode(httpData.responseBody!) as Map<String, dynamic>;
      final List<dynamic> templates = data["template_overview"]["attributes"][0]
          ["current_attribute_value"] as List<dynamic>;

      final List<OverviewPageRow> rows = [];
      pageNotifier.maxPage = 1;

      for (dynamic template in templates) {
        rows.add(OverviewPageRow(
          id: template["_id"],
          name: template["_id"],
          visibleColumns: visibleColumns,
          columnValues: const {},
          allIds: allIds,
          selectedIds: selectedIds,
        ));
      }

      return rows;
    }

    return getRows;
  }

  Future<
      (
        List<OverviewPageColumnData>,
        Future<List<OverviewPageRow>> Function(
          FilterNotifier filters,
          ColumnsNotifier columns,
          Set<String> allIds,
          IdSetNotifier selectedIds,
          PageNotifier pageNotifier,
          bool updateColumns,
        )
      )> getPagesOverviewData() async {
    return (await getPagesColumns(), getPagesRows());
  }

  Future<List<FilterSetupData>> getFilters() async {
    return [
      FilterSetupData(
          key: "string_filter_key",
          name: "String Filter",
          type: FilterSetupTypeData.string),
      FilterSetupData(
          key: "range_filter_key",
          name: "Range Filter",
          type: FilterSetupTypeData.range),
    ];
  }

  final FilterNotifier filters = FilterNotifier();
  final PageNotifier pageNotifier = PageNotifier(pageSize: 10);

  @override
  Widget build(BuildContext context) {
    final UserParameterCollection userParameterCollection =
        UserParameterCollection();

    userParameterCollection.addParameter(
      TextUserParameter(
        "key",
        userParameterCollection.parameterValueStorage,
      ),
    );

    return FutureBuilder(
      future: getPagesOverviewData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          final ColumnsNotifier columnsNotifier = ColumnsNotifier(
            columns: snapshot.data!.$1,
          );

          return OverviewPage(
            columns: columnsNotifier,
            visibleColumns: visibleColumns,
            filters: filters,
            pageNotifier: pageNotifier,
            getPages: RetrieveOverviewPagePages(
              getRows: snapshot.data!.$2,
              filters: filters,
              allIds: allIds,
              selectedIds: selectedIds,
              pageNotifier: pageNotifier,
              columns: columnsNotifier,
            ),
            individualName: "template",
            allIds: allIds,
            selectedIds: selectedIds,
            bulkActions: [
              DeletePagesBulkAction(
                selectedIds: selectedIds,
                userParameterCollection: userParameterCollection,
              ),
              DeletePagesBulkAction(
                selectedIds: selectedIds,
                userParameterCollection: userParameterCollection,
              ),
            ],
            getFilters: getFilters,
            newUrl: "/content/templates/newTemplate",
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text("An error has occurred: ${snapshot.error.toString()}"),
          );
        }

        // TODO: replace this with ExdockLoadingPageAnimation once available on the main branch
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
