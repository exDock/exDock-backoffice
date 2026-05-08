// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:exdock_backoffice/utils/settings.dart';

// Custom ChangeNotifier for a String value
class StringNotifier extends ChangeNotifier {
  String _value;

  StringNotifier(this._value);

  String get value => _value;

  set value(String newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }
}

StringNotifier pathNotifier = StringNotifier(Uri.base.path);

late final SharedPreferencesWithCache prefs;

late final Settings settings;
