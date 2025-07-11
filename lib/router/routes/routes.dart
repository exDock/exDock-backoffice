// Flutter imports:
// Project imports:
import 'package:exdock_backoffice/router/routes/catalog.dart';
import 'package:exdock_backoffice/router/routes/content.dart';
import 'package:exdock_backoffice/router/routes/customers.dart';
import 'package:exdock_backoffice/router/routes/files.dart';
import 'package:exdock_backoffice/router/routes/home.dart';
import 'package:exdock_backoffice/router/routes/marketing.dart';
import 'package:exdock_backoffice/router/routes/reports.dart';
import 'package:exdock_backoffice/router/routes/sales.dart';
import 'package:exdock_backoffice/router/routes/stores.dart';
import 'package:exdock_backoffice/router/routes/system.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:go_router/go_router.dart';

List<GoRoute> getRoutes() {
  return [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const Placeholder(child: Center(child: Text("root"))),
    ),
    ...getHomeRoutes(),
    ...getSalesRoutes(),
    ...getCatalogRoutes(),
    ...getCustomersRoutes(),
    ...getMarketingRoutes(),
    ...getContentRoutes(),
    ...getReportsRoutes(),
    ...getStoresRoutes(),
    ...getFilesRoutes(),
    ...getSystemRoutes(),
  ];
}
