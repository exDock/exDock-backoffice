// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:exdock_backoffice/globals/variables.dart';
import 'package:exdock_backoffice/pages/login/login.dart';
import 'package:exdock_backoffice/pages/page_wrapper/scope.dart';
import 'package:exdock_backoffice/pages/page_wrapper/side_bar/side_bar.dart';
import 'package:exdock_backoffice/pages/page_wrapper/top_bar/top_bar.dart';
import 'package:exdock_backoffice/router/routes/routes.dart';
import 'package:exdock_backoffice/utils/authentication/authentication_data.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    ShellRoute(
      redirect: (context, state) {
        try {
          return null;
        } on NotAuthenticatedException catch (_) {
          return '/login';
        }
      },
      builder: (context, GoRouterState state, child) {
        pathNotifier.value = state.uri.path;
        return Scaffold(
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Stack(
                        children: [
                          child,
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Scope(),
                          ),
                        ],
                      ),
                    ),
                    const TopBar(
                      height: 100,
                    ),
                  ],
                ),
              ),
              const SideBar(width: 100),
            ],
          ),
        );
      },
      routes: getRoutes(),
    ),
  ],
);
