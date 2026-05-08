// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/overview_page/filters/types/filter.dart';

class FilterNotifier extends ValueNotifier<Map<String, FilterData>> {
  FilterNotifier() : super({});

  bool _isChanged = false;

  /// Are there any un-notified changes?
  bool get isChanged => _isChanged;

  void addFilter(FilterData newValue, {bool silent = false}) {
    value[newValue.key] = newValue;

    if (silent) {
      _isChanged = true;
      return;
    }

    notifyListeners();
  }

  /// Returns true if a filter with this key exists
  bool keyExists(String key) {
    return value.containsKey(key);
  }

  /// Returns true if this filter exists
  bool filterExists(FilterData filter) {
    return keyExists(filter.key);
  }

  /// Returns true if the filter existed
  bool removeFilter(FilterData filter, {bool silent = false}) {
    final bool output = value.remove(filter.key) != null;

    if (silent) {
      _isChanged = true;
      return output;
    }

    notifyListeners();
    return output;
  }

  /// Returns true if the key existed
  bool removeKey(String key, {bool silent = false}) {
    final bool output = value.remove(key) != null;

    if (silent) {
      _isChanged = true;
      return output;
    }

    notifyListeners();
    return output;
  }

  /// Returns true if there were un-notified changes
  bool notify({bool onlyIfChanged = false}) {
    final bool isChanged = _isChanged;
    if (onlyIfChanged && !_isChanged) {
      return false;
    }
    notifyListeners();
    _isChanged = false;

    return isChanged;
  }

  void reset() {
    value.clear();
    notifyListeners();
  }
}
