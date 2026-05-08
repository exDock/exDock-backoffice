// Project imports:
import 'package:exdock_backoffice/widgets/overview_page/filters/types/filter.dart';

class StringFilterData extends FilterData {
  StringFilterData({
    required super.name,
    required super.key,
    required this.value,
  });

  String value;

  @override
  MapEntry<String, dynamic> get filterParameter => MapEntry(key, value);

  @override
  String get displayValue => value;
}
