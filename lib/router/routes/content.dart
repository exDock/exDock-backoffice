// Flutter imports:
import 'package:exdock_backoffice/pages/content/pages/page_info/page_info.dart';
// Project imports:
import 'package:exdock_backoffice/pages/content/pages/pages_overview.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:go_router/go_router.dart';

List<GoRoute> getContentRoutes() {
  return [
    GoRoute(
      path: '/content',
      builder: (context, state) => const Placeholder(),
    ),
    GoRoute(
      path: '/content/pages',
      builder: (context, state) => const PagesOverview(),
    ),
    GoRoute(
        path: '/content/pages/:key',
        builder: (context, state) {
          String? key;
          try {
            key = state.pathParameters['key'];
          } catch (_) {}
          return PageInfo(
            url: key!,
          );
        })
  ];
}
