// Project imports:
import 'package:exdock_backoffice/utils/id_set_notifier.dart';
import 'package:exdock_backoffice/utils/user_parameters/user_parameter_collection.dart';

abstract class BulkAction {
  const BulkAction({
    required this.name,
    required this.selectedIds,
    required this.userParameterCollection,
  });

  /// The name of the bulk action
  final String name;

  /// The ids of the rows that are selected
  final IdSetNotifier selectedIds;

  /// The user parameters for this bulk action
  final UserParameterCollection userParameterCollection;

  /// The function that is called when the bulk action is executed
  void execute({
    required Function() onSuccess,
    required Function() onFailure,
  });
}
