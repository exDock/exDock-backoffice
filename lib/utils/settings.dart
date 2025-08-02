// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:exdock_backoffice/globals/variables.dart';

class Settings {
  Map<String, dynamic> settingsMap = {};
  Map<String, dynamic> oldSettings = {};

  Settings(String jsonSettingsString) {
    settingsMap = Map<String, dynamic>.from(jsonDecode(jsonSettingsString));
  }

  T getSetting<T>(String key) {
    try {
      if (prefs.containsKey(key)) {
        return prefs.get(key) as T;
      } else {
        if (settingsMap.containsKey(key)) {
          final dynamic value = settingsMap[key];
          if (value is T) {
            return value;
          } else {
            throw Exception("Type mismatch for key: $key");
          }
        }
        throw Exception("Could not find setting: $key");
      }
    } catch (e) {
      rethrow;
    }
  }

  void setSetting<T>(String key, T value) {
    if (settingsMap.containsKey(key)) {
      settingsMap[key] = value;
    } else {
      switch (T.toString()) {
        case "String":
          {
            prefs.setString(key, value as String);
            break;
          }
        case "int":
          {
            prefs.setInt(key, value as int);
            break;
          }
        case "double":
          {
            prefs.setDouble(key, value as double);
            break;
          }
        case "bool":
          {
            prefs.setBool(key, value as bool);
            break;
          }
        default:
          {
            prefs.setString(key, jsonEncode(value));
            break;
          }
      }
    }
  }

  bool containsSetting(String key) {
    return settingsMap.containsKey(key) || prefs.containsKey(key);
  }

  List<String> getSettingsKeys() {
    return settingsMap.keys.toList();
  }

  Map<String, dynamic> saveSettings(Map<String, dynamic> settingsMap) {
    final Map<String, dynamic> serverSettings = {};
    final List<String> keys = getSettingsKeys();

    for (final MapEntry<String, dynamic> entry in settingsMap.entries) {
      if (keys.contains(entry.key)) {
        final dynamic currentValue = getSetting(entry.key);
        oldSettings[entry.key] = currentValue;

        setSetting(entry.key, entry.value);
      } else {
        serverSettings[entry.key] = entry.value;
      }
    }

    return serverSettings;
  }

  void restoreSettings() {
    saveSettings(oldSettings);
  }

  void removeOldSettings() {
    oldSettings = {};
  }
}
