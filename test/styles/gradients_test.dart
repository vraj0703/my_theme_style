import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_theme_style/my_theme_style.dart';
import 'package:my_theme_style/styles/gradients.dart';

void main() {
  group('AppGradients', () {
    final config = {
      "linear": {
        "type": "linear",
        "colors": [
          {"color": "#FF0000", "stop": 0.0},
          {"color": "#0000FF", "stop": 1.0},
        ],
        "begin": "topLeft",
        "end": "bottomRight",
      },
      "themeAware": {
        "light": {
          "type": "linear",
          "colors": [
            {"color": "#FFFFFF", "stop": 0.0},
            {"color": "#000000", "stop": 1.0},
          ],
        },
        "dark": {
          "type": "linear",
          "colors": [
            {"color": "#000000", "stop": 0.0},
            {"color": "#FFFFFF", "stop": 1.0},
          ],
        },
      },
      "rainbow": {
        "type": "linear",
        "colors": [
          {"color": "#FF0000", "stop": 0.0},
          {"color": "#FF7F00", "stop": 0.17},
          {"color": "#FFFF00", "stop": 0.33},
          {"color": "#00FF00", "stop": 0.5},
          {"color": "#0000FF", "stop": 0.67},
          {"color": "#4B0082", "stop": 0.83},
          {"color": "#9400D3", "stop": 1.0},
        ],
        "begin": "topLeft",
        "end": "bottomRight",
      },
    };

    test('parses linear gradient with object list', () {
      final gradients = AppGradients.fromJson(config);
      final gradient = gradients.gradient('linear') as LinearGradient;
      expect(gradient, isNotNull);
      expect(gradient.colors, [
        const Color(0xFFFF0000),
        const Color(0xFF0000FF),
      ]);
      expect(gradient.stops, [0.0, 1.0]);
      expect(gradient.begin, Alignment.topLeft);
      expect(gradient.end, Alignment.bottomRight);
    });

    test('resolves theme aware gradient with object list', () {
      final gradients = AppGradients.fromJson(config);

      MyThemeStyle.setTheme('light');
      final lightGradient = gradients.gradient('themeAware') as LinearGradient;
      expect(lightGradient.colors.first, const Color(0xFFFFFFFF));
      expect(lightGradient.stops?.first, 0.0);

      MyThemeStyle.setTheme('dark');
      final darkGradient = gradients.gradient('themeAware') as LinearGradient;
      expect(darkGradient.colors.first, const Color(0xFF000000));
      expect(darkGradient.stops?.first, 0.0);
    });

    test('parses rainbow gradient with object list', () {
      final gradients = AppGradients.fromJson(config);
      final gradient = gradients.gradient('rainbow') as LinearGradient;
      expect(gradient, isNotNull);
      expect(gradient.colors.length, 7);
      expect(gradient.stops?.length, 7);
      expect(gradient.colors.first, const Color(0xFFFF0000));
      expect(gradient.colors.last, const Color(0xFF9400D3));
      expect(gradient.stops?.first, 0.0);
      expect(gradient.stops?.last, 1.0);
    });

    test('returns null for missing key', () {
      final gradients = AppGradients.fromJson(config);
      expect(gradients.gradient('missing'), isNull);
    });

    test('dynamic access works', () {
      final gradients = AppGradients.fromJson(config);
      final gradient = (gradients as dynamic).linear as LinearGradient;
      expect(gradient, isNotNull);
    });
  });
}
