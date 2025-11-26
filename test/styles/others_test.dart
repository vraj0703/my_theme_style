import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_theme_style/styles/corners.dart';
import 'package:my_theme_style/styles/shadows.dart';
import 'package:my_theme_style/styles/times.dart';
import 'package:my_theme_style/styles/insets.dart';
import 'package:my_theme_style/styles/sizes.dart';

void main() {
  group('Corners', () {
    test('parses JSON correctly', () {
      final corners = Corners.fromJson({
        "radius": {"medium": 12.0},
      });
      expect(corners.medium, 12.0);
    });
  });

  group('Shadows', () {
    test('parses JSON correctly', () {
      final shadows = Shadows.fromJson({
        "elevation": {
          "level1": {
            "color": "#000000",
            "opacity": 0.3,
            "x": 0,
            "y": 1,
            "blur": 2,
            "spread": 0,
          },
        },
      });
      expect(shadows.level1.first.blurRadius, 2.0);
      expect(shadows.level1.first.offset, const Offset(0, 1));
    });
  });

  group('Times', () {
    test('parses JSON correctly', () {
      final times = Times.fromJson({
        "durations": {"short1": 50},
        "easings": {"standard": "Cubic(0.2, 0.0, 0.0, 1.0)"},
      });
      expect(times.short1.inMilliseconds, 50);
      expect(times.standard, isA<Cubic>());
    });
  });

  group('Insets', () {
    test('parses JSON correctly', () {
      final insets = Insets.fromJson({
        "padding": {"md": 16.0},
      });
      expect(insets.md, 16.0);
    });
  });

  group('Sizes', () {
    test('parses JSON correctly', () {
      final sizes = Sizes.fromJson({
        "icon": {"md": 24.0},
      });
      expect(sizes.iconMd, 24.0);
    });
  });
}
