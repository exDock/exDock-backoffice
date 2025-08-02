// Dart imports:
import 'dart:async';
import 'dart:developer' as developer;

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:exdock_backoffice/router/router.dart';
import 'package:exdock_backoffice/utils/startup.dart';

void main() async {
  // --- Use runZonedGuarded as the outermost error handler ---
  // This will catch ALL unhandled errors, synchronous or asynchronous,
  // that occur within its zone, including those that might somehow
  // bypass FlutterError.onError.
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      GoRouter.optionURLReflectsImperativeAPIs = true;
      usePathUrlStrategy();

      // Explicitly handle errors during application startup.
      // Errors here that are not caught will be caught by runZonedGuarded.
      try {
        await applicationStartUp();
      } catch (e, st) {
        developer.log(
          'Critical error during application startup (caught by main\'s try-catch): $e',
          name: 'exDock Backend Client',
          error: e,
          stackTrace: st,
        );
      }

      runApp(const MyApp());
    },
    (Object error, StackTrace stack) {
      // The router should be initialized because main() would have run MyApp (or is global).
      if (router.configuration.routes.isNotEmpty &&
          error.runtimeType.toString() == "NotAuthenticatedException") {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          router.push('/login');
        });
      } else {
        developer.log(
          'An uncaught error occurred in runZonedGuarded: $error',
          name: 'exDock Backend Client (runZonedGuarded)',
          error: error,
          stackTrace: stack,
        );

        // Optional: Dump Flutter error details to console in debug mode
        if (kDebugMode) {
          FlutterError.dumpErrorToConsole(
            FlutterErrorDetails(exception: error, stack: stack),
          );
        }
      }
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'exDock backend client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff264653)),
        cardColor: Colors.white,
        useMaterial3: true,
      ),
    );
  }
}
