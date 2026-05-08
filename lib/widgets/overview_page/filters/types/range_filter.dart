// Project imports:
import 'package:exdock_backoffice/widgets/overview_page/filters/types/filter.dart';

class RangeFilterData extends FilterData {
  RangeFilterData({
    required super.name,
    required super.key,
    this.min,
    this.max,
  });

  num? min;
  num? max;

  @override
  MapEntry<String, dynamic> get filterParameter {
    final Map<String, num?> value = {};

    if (min != null) value['min'] = min;
    if (max != null) value['max'] = max;

    return MapEntry(key, value);
  }

  @override
  String get displayValue => "$min - $max";
}
