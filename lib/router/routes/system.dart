// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:exdock_backoffice/pages/system/system.dart';

List<GoRoute> getSystemRoutes() {
  return [
    GoRoute(
      path: '/system',
      builder: (context, state) => const System(),
    ),
  ];
}
