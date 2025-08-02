// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:exdock_backoffice/pages/files/files.dart';

List<GoRoute> getFilesRoutes() {
  return [
    GoRoute(
      path: '/files',
      builder: (context, state) => const Files(),
    ),
  ];
}
