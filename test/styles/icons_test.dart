import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_theme_style/styles/icons.dart';

void main() {
  group('AppIcons', () {
    final iconsMap = {
      "icons": {"back": "arrow_back", "custom": "home"},
    };

    test('parses JSON correctly', () {
      final icons = AppIcons.fromJson(iconsMap);
      expect(icons.back, Icons.arrow_back);
      expect(icons.home, Icons.home); // Default
    });

    test('uses defaults if missing', () {
      final icons = AppIcons.fromJson({});
      expect(icons.close, Icons.close);
    });
  });
}
