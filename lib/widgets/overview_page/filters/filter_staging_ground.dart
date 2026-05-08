// Project imports:
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/types/filter.dart';

class FilterStagingGround {
  FilterStagingGround({
    required this.filterNotifier,
  });

  final FilterNotifier filterNotifier;
  final Map<String, FilterData> changedFilters = {};
  final List<String> filtersToRemove = [];

  /// Changes or add a filter if it doesn't exist.
  /// Returns true if after the change, the filter is in the staging ground.
  bool changeFilter(FilterData filterData) {
    if (!filterNotifier.value.containsKey(filterData.key)) {
      changedFilters[filterData.key] = filterData;
      return true;
    }

    if (filterNotifier.value[filterData.key] != filterData) {
      changedFilters[filterData.key] = filterData;
      return true;
    }

    if (filterNotifier.value.containsKey(filterData.key)) {
      changedFilters.remove(filterData.key);
      filtersToRemove.add(filterData.key);
    }

    return false;
  }

  /// Returns true if there were un-notified changes
  bool commit() {
    for (final FilterData value in changedFilters.values) {
      filterNotifier.addFilter(value, silent: true);
    }

    for (final String key in filtersToRemove) {
      filterNotifier.removeKey(key, silent: true);
    }

    changedFilters.clear();
    return filterNotifier.notify(onlyIfChanged: true);
  }
}
