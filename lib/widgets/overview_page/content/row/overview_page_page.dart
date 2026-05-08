// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/overview_page/content/row/overview_page_row.dart';

class OverviewPagePage {
  OverviewPagePage({
    required this.pageNumber,
    required this.rows,
    required this.getRows,
    DateTime? lastUpdated,
  }) : _lastUpdated = lastUpdated ?? DateTime.now();

  final int pageNumber;
  final Future<List<OverviewPageRow>> Function() getRows;
  List<OverviewPageRow> rows;
  DateTime _lastUpdated;

  DateTime get lastUpdated => _lastUpdated;

  Future<List<OverviewPageRow>> refreshPage({
    Function()? onComplete,
    ValueNotifier<bool>? valueNotifier,
  }) async {
    rows = await getRows();
    _lastUpdated = DateTime.now();

    if (onComplete != null) onComplete();
    if (valueNotifier != null) valueNotifier.value = true;

    return rows;
  }

  bool get exists => rows.isNotEmpty;
}
