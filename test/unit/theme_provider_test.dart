import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow_hub/presentation/providers/theme_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeProvider', () {
    test('defaults to system theme', () async {
      SharedPreferences.setMockInitialValues({});
      final preferences = await SharedPreferences.getInstance();
      final provider = ThemeProvider(preferences);

      expect(provider.themeMode, ThemeMode.system);
    });

    test('persists theme mode changes', () async {
      SharedPreferences.setMockInitialValues({});
      final preferences = await SharedPreferences.getInstance();
      final provider = ThemeProvider(preferences);

      await provider.setThemeMode(ThemeMode.dark);
      expect(provider.themeMode, ThemeMode.dark);

      final restored = ThemeProvider(preferences);
      expect(restored.themeMode, ThemeMode.dark);
    });

    test('cycles through theme modes', () async {
      SharedPreferences.setMockInitialValues({});
      final preferences = await SharedPreferences.getInstance();
      final provider = ThemeProvider(preferences);

      await provider.cycleThemeMode();
      expect(provider.themeMode, ThemeMode.light);

      await provider.cycleThemeMode();
      expect(provider.themeMode, ThemeMode.dark);
    });
  });
}
