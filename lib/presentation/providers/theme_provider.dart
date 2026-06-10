import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(this._preferences) {
    _themeMode = _readStoredThemeMode();
  }

  final SharedPreferences _preferences;
  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) {
      return;
    }
    _themeMode = mode;
    await _preferences.setString(AppConstants.themeModeKey, mode.name);
    notifyListeners();
  }

  Future<void> cycleThemeMode() async {
    final next = switch (_themeMode) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
    };
    await setThemeMode(next);
  }

  ThemeMode _readStoredThemeMode() {
    final stored = _preferences.getString(AppConstants.themeModeKey);
    if (stored == null) {
      return ThemeMode.system;
    }
    return ThemeMode.values.byName(stored);
  }
}
