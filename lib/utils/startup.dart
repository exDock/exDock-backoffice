// Package imports:

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:exdock_backoffice/globals/variables.dart';
import 'package:exdock_backoffice/utils/settings.dart';

Future<void> applicationStartUp() async {
  const SharedPreferencesWithCacheOptions preferencesWithCacheOptions =
      SharedPreferencesWithCacheOptions();

  prefs = await SharedPreferencesWithCache.create(
    cacheOptions: preferencesWithCacheOptions,
  );
  final String jsonConfig = await rootBundle.loadString("assets/config.json");
  settings = Settings(jsonConfig);
}
