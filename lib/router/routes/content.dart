// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:exdock_backoffice/pages/content/pages/pages_overview.dart';
import 'package:exdock_backoffice/pages/content/templates/page_info/page_info.dart';
import 'package:exdock_backoffice/pages/content/templates/templates_overview.dart';

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
      path: "/content/templates",
      builder: (context, state) {
        return const TemplatesOverview();
      },
    ),
    GoRoute(
      path: '/content/templates/newTemplate',
      builder: (context, state) {
        return const PageInfo(
          url: "",
          isNewPage: true,
        );
      },
    ),
    GoRoute(
      path: '/content/templates/:key',
      builder: (context, state) {
        String? key;
        try {
          key = state.pathParameters['key'];
        } catch (_) {}
        return PageInfo(
          url: key!,
          isNewPage: false,
        );
      },
    ),
  ];
}
