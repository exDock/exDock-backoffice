// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/overview_page/content/columns/overview_page_column.dart';

class ColumnsNotifier extends ValueNotifier<List<OverviewPageColumnData>> {
  ColumnsNotifier({
    required List<OverviewPageColumnData> visibleColumns,
  }) : super(visibleColumns);
  bool isChanged = false;

  bool containsColumn(OverviewPageColumnData column) {
    return value.contains(column);
  }

  void addColumn(OverviewPageColumnData column) {
    value.add(column);
    notifyListeners();
  }

  void removeColumn(OverviewPageColumnData column) {
    value.remove(column);
    notifyListeners();
  }

  void silentAddColumn(OverviewPageColumnData column) {
    isChanged = true;
    value.add(column);
  }

  void silentRemoveColumn(OverviewPageColumnData column) {
    isChanged = true;
    value.remove(column);
  }

  void notify({bool onlyIfChanged = false}) {
    if (onlyIfChanged && !isChanged) return;

    notifyListeners();
    isChanged = false;
  }
}
