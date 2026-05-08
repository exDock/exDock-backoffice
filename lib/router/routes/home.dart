// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:exdock_backoffice/pages/home/home.dart';

List<GoRoute> getHomeRoutes() {
  return [
    GoRoute(path: '/home', builder: (context, state) => const Home()),
  ];
}
