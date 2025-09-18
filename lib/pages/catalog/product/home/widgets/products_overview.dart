import 'dart:convert';

import 'package:exdock_backoffice/pages/catalog/product/home/products_overview_sync.dart';
import 'package:exdock_backoffice/utils/HTTP/get_request.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/id_set_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/bulk/bulk_action.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/columns/overview_page_column.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/overview_page_row.dart';
import 'package:exdock_backoffice/widgets/overview_page/content/row/retrieve_overview_page_pages.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/visible_columns_notifier.dart';
import 'package:exdock_backoffice/widgets/pagination/page_notifier.dart';
import 'package:flutter/material.dart';

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
  final List<OverviewPageColumnData> columns = [
    OverviewPageColumnData(columnKey: 'TODO', name: "TODO column"),
  ]; // TODO: Retrieve columns from backend
  late final RetrieveOverviewPagePages getPages;
  late final visibleColumns = VisibleColumnsNotifier(
    visibleColumns: columns, // TODO: save visible columns state
  );

  Future<List<OverviewPageRow>> getRows(
    FilterNotifier filters,
    List<OverviewPageColumnData>? columns,
    Set<String> allIds,
    IdSetNotifier selectedIds,
    PageNotifier pageNotifier,
  ) async {
    final HttpData response =
        await standardGetRequest('/api/v1/products/overview');

    if (response.statusCode != 200 || response.responseBody == null) {
      return [];
    }

    final jsonList = jsonDecode(response.responseBody!) as List;
    final List<OverviewPageRow> rows = [];

    for (final json in jsonList) {
      final id = json["_id"];
      allIds.add(id);
      print("allIds: $allIds");

      print("json: $json");
      // continue;
      rows.add(OverviewPageRow(
        id: id,
        name: json['name'],
        visibleColumns: visibleColumns,
        columnValues: {"TODO": "todo"},
        allIds: allIds,
        selectedIds: selectedIds,
      ));

      selectedIds.allIds = allIds;
      selectedIds.sanitise();
    }

    return rows;
  }

  @override
  void initState() {
    getPages = RetrieveOverviewPagePages(
      getRows: getRows,
      filters: filters,
      allIds: allIds,
      selectedIds: selectedIds,
      pageNotifier: pageNotifier,
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
    );
  }
}
