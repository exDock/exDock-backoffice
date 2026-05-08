// Project imports:
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_setup/filter_setup_type_data.dart';

class FilterSetupData {
  FilterSetupData({
    required this.key,
    name,
    required this.type,
  }) : _name = name;

  final String key;
  final String? _name;
  final FilterSetupTypeData type;

  String get name => _name ?? key;
}
