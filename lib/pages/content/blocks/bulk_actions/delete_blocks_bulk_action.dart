import 'package:exdock_backend_client/widgets/overview_page/bulk/bulk_action.dart';

class DeleteBlocksBulkAction extends BulkAction {
  DeleteBlocksBulkAction({
    required super.selectedIds,
    required super.userParameterCollection,
  }) : super(name: "Delete Blocks");

  @override
  void execute({required Function() onSuccess, required Function() onFailure}) {
    // TODO: implement execute
    throw UnimplementedError(
        "TODO: implement the delete blocks bulk actions server request");
  }
}
