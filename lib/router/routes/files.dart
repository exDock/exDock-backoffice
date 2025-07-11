// Flutter imports:
import 'package:exdock_backoffice/pages/files/files.dart';
// Package imports:
import 'package:go_router/go_router.dart';

List<GoRoute> getFilesRoutes() {
  return [
    GoRoute(
      path: '/files',
      builder: (context, state) => const Files(),
    ),
  ];
}
