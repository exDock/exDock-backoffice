// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:exdock_backoffice/pages/stores/configuration/configuration.dart';

List<GoRoute> getStoresRoutes() {
  return [
    GoRoute(
      path: '/stores',
      builder: (context, state) => const Placeholder(),
    ),
    GoRoute(
      path: '/stores/configuration',
      builder: (context, state) => const Configuration(),
    ),
    GoRoute(
      path:
          '/stores/configuration/:configurationDataHeadKey/:configurationDataSubKey',
      builder: (context, state) => Configuration(
        configurationDataKey:
            '${state.pathParameters['configurationDataHeadKey']}/${state.pathParameters['configurationDataSubKey']}',
      ),
    ),
  ];
}
