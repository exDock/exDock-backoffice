// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/content/pages/bulk_actions/delete_pages_bulk_action.dart';
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

class PagesOverview extends StatefulWidget {
  const PagesOverview({super.key});

  @override
  State<PagesOverview> createState() => _PagesOverviewState();
}

class _PagesOverviewState extends State<PagesOverview> {
  final ColumnsNotifier visibleColumns = ColumnsNotifier(visibleColumns: []);
  Set<String> allIds = {};
  late IdSetNotifier selectedIds = IdSetNotifier(allIds);

  Future<List<OverviewPageColumnData>> getPagesColumns() async {
    return [
      const OverviewPageColumnData(columnKey: "column_1", name: "Column 1"),
      const OverviewPageColumnData(columnKey: "column_2", name: "Column 2"),
      const OverviewPageColumnData(columnKey: "column_3", name: "Column 3"),
      const OverviewPageColumnData(columnKey: "column_4", name: "Column 4"),
    ];
  }

  Future<List<OverviewPageRow>> Function(
    FilterNotifier filters,
    List<OverviewPageColumnData>? columns,
    Set<String> allIds,
    IdSetNotifier selectedIds,
    PageNotifier pageNotifier,
  ) getPagesRows() {
    Future<List<OverviewPageRow>> getRows(
      FilterNotifier filters,
      List<OverviewPageColumnData>? columns,
      Set<String> allIds,
      IdSetNotifier selectedIds,
      PageNotifier pageNotifier,
    ) async {
      pageNotifier.maxPage = 1;
      if (pageNotifier.value == 0) {
        return [
          OverviewPageRow(
            id: 'page_1',
            name: "Page 1",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
            },
            allIds: allIds,
            selectedIds: selectedIds,
            onSelect: () {
              // ignore: avoid_print
              print("row selected: 1");
            },
          ),
          OverviewPageRow(
            id: 'page_2',
            name: "Page 2",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
          OverviewPageRow(
            id: 'page_3',
            name: "Page 3",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
              "column_4": "value_4",
              "column_5": "value_5",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
          OverviewPageRow(
            id: 'page_4',
            name: "Page 4",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
              "column_4": "value_4",
              "column_5": "value_5",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
          OverviewPageRow(
            id: 'page_5',
            name: "Page 5",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
              "column_4": "value_4",
              "column_5": "value_5",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
          OverviewPageRow(
            id: 'page_6',
            name: "Page 6",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
              "column_4": "value_4",
              "column_5": "value_5",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
          OverviewPageRow(
            id: 'page_7',
            name: "Page 7",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
              "column_4": "value_4",
              "column_5": "value_5",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
          OverviewPageRow(
            id: 'page_8',
            name: "Page 8",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
              "column_4": "value_4",
              "column_5": "value_5",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
          OverviewPageRow(
            id: 'page_9',
            name: "Page 9",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
              "column_4": "value_4",
              "column_5": "value_5",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
          OverviewPageRow(
            id: 'page_10',
            name: "Page 10",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
              "column_4": "value_4",
              "column_5": "value_5",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
        ];
      }
      if (pageNotifier.value == 1) {
        return [
          OverviewPageRow(
            id: 'page_11',
            name: "Page 11",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
              "column_4": "value_4",
              "column_5": "value_5",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
          OverviewPageRow(
            id: 'page_12',
            name: "Page 12",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
              "column_4": "value_4",
              "column_5": "value_5",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
          OverviewPageRow(
            id: 'page_13',
            name: "Page 13",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
              "column_4": "value_4",
              "column_5": "value_5",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
          OverviewPageRow(
            id: 'page_14',
            name: "Page 14",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
              "column_4": "value_4",
              "column_5": "value_5",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
          OverviewPageRow(
            id: 'page_15',
            name: "Page 15",
            visibleColumns: visibleColumns,
            columnValues: const {
              "column_1": "value_1",
              "column_2": "value_2",
              "column_3": "value_3",
              "column_4": "value_4",
              "column_5": "value_5",
            },
            allIds: allIds,
            selectedIds: selectedIds,
          ),
        ];
      }
      throw Exception("In this mock data, only 2 pages exist");
    }

    return getRows;
  }

  Future<
      (
        List<OverviewPageColumnData>,
        Future<List<OverviewPageRow>> Function(
          FilterNotifier filters,
          List<OverviewPageColumnData>? columns,
          Set<String> allIds,
          IdSetNotifier selectedIds,
          PageNotifier pageNotifier,
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
          return OverviewPage(
            columns: snapshot.data!.$1,
            visibleColumns: visibleColumns,
            filters: filters,
            pageNotifier: pageNotifier,
            getPages: RetrieveOverviewPagePages(
              getRows: snapshot.data!.$2,
              filters: filters,
              allIds: allIds,
              selectedIds: selectedIds,
              pageNotifier: pageNotifier,
            ),
            individualName: "page",
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
