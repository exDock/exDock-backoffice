// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/product/home/products_overview_sync.dart';
import 'package:exdock_backoffice/utils/HTTP/get_request.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/id_set_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/bulk/bulk_action.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/columns/overview_page_column.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/overview_page_row.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/retrieve_overview_page_pages.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_setup/filter_setup.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/columns_notifier.dart';
import 'package:exdock_backoffice/widgets/pagination/page_notifier.dart';

class ProductsOverview extends StatefulWidget {
  const ProductsOverview({super.key});

  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  final allIds = <String>{};
  final selectedIds = IdSetNotifier(<String>{});
  final filters = FilterNotifier();
  final pageNotifier = PageNotifier();
  final List<BulkAction> bulkActions = [];
  final columns = ColumnsNotifier(
    columns: [],
  ); // TODO: cache columns
  // final List<OverviewPageColumnData> columns = [
  //   OverviewPageColumnData(columnKey: 'TODO', name: "TODO column"),
  // ]; // TODO: Retrieve columns from backend
  late final RetrieveOverviewPagePages getPages;
  late final visibleColumns = ColumnsNotifier(
    columns: [], // TODO: save visible columns state
  );

  Future<List<OverviewPageRow>> getRows(
    FilterNotifier filters,
    ColumnsNotifier columns,
    Set<String> allIds,
    IdSetNotifier selectedIds,
    PageNotifier pageNotifier,
    bool updateColumns,
  ) async {
    final HttpData response = await standardGetRequest(
        '/api/v1/products/overview${updateColumns ? '?columns=1' : ''}');

    if (response.statusCode != 200 || response.responseBody == null) {
      return [];
    }

    final jsonMap = Map<String, List>.from(jsonDecode(response.responseBody!));
    final products = jsonMap['products']!;
    final List<OverviewPageRow> rows = [];

    for (final json in products) {
      final id = json["_id"]["\$oid"];
      allIds.add(id);

      if (updateColumns) {
        final jsonColumns = jsonMap['columns'] as List;
        final List<OverviewPageColumnData> newColumns = [];

        for (final jsonColumn in jsonColumns) {
          newColumns.add(OverviewPageColumnData(
            columnKey: jsonColumn['key'],
            name: jsonColumn['name'],
          ));
        }

        columns.value = newColumns;
      }

      rows.add(OverviewPageRow(
        id: id,
        name: json['name'],
        visibleColumns: visibleColumns,
        columnValues: json,
        allIds: allIds,
        selectedIds: selectedIds,
        onSelect: () {
          context.push('/catalog/product/$id');
        },
      ));

      selectedIds.allIds = allIds;
      selectedIds.sanitise();
    }

    return rows;
  }

  Future<List<FilterSetupData>> getFilters() async {
    return []; // TODO: Retrieve filters from backend
  }

  @override
  void initState() {
    getPages = RetrieveOverviewPagePages(
      getRows: getRows,
      filters: filters,
      allIds: allIds,
      selectedIds: selectedIds,
      pageNotifier: pageNotifier,
      columns: columns,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProductsOverviewSync(
      allIds: allIds,
      columns: columns,
      visibleColumns: visibleColumns,
      getPages: getPages,
      bulkActions: bulkActions,
      filters: filters,
      pageNotifier: pageNotifier,
      getFilters: getFilters,
    );
  }
}
