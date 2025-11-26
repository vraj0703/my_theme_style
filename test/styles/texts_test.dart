import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_theme_style/styles/texts.dart';

void main() {
  group('Texts', () {
    final textStylesMap = {
      "styles": {
        "md.sys.typescale": {
          "display-large": {
            "fontFamily": "Roboto",
            "fontWeight": "400",
            "fontSize": 57,
            "lineHeight": 64,
            "letterSpacing": -0.25,
          },
          "display-medium": {
            "fontFamily": "Roboto",
            "fontWeight": "400",
            "fontSize": 45,
            "lineHeight": 52,
            "letterSpacing": 0,
          },
          "display-small": {
            "fontFamily": "Roboto",
            "fontWeight": "400",
            "fontSize": 36,
            "lineHeight": 44,
            "letterSpacing": 0,
          },
          "headline-large": {
            "fontFamily": "Roboto",
            "fontWeight": "400",
            "fontSize": 32,
            "lineHeight": 40,
            "letterSpacing": 0,
          },
          "headline-medium": {
            "fontFamily": "Roboto",
            "fontWeight": "400",
            "fontSize": 28,
            "lineHeight": 36,
            "letterSpacing": 0,
          },
          "headline-small": {
            "fontFamily": "Roboto",
            "fontWeight": "400",
            "fontSize": 24,
            "lineHeight": 32,
            "letterSpacing": 0,
          },
          "title-large": {
            "fontFamily": "Roboto",
            "fontWeight": "400",
            "fontSize": 22,
            "lineHeight": 28,
            "letterSpacing": 0,
          },
          "title-medium": {
            "fontFamily": "Roboto",
            "fontWeight": "500",
            "fontSize": 16,
            "lineHeight": 24,
            "letterSpacing": 0.15,
          },
          "title-small": {
            "fontFamily": "Roboto",
            "fontWeight": "500",
            "fontSize": 14,
            "lineHeight": 20,
            "letterSpacing": 0.1,
          },
          "label-large": {
            "fontFamily": "Roboto",
            "fontWeight": "500",
            "fontSize": 14,
            "lineHeight": 20,
            "letterSpacing": 0.1,
          },
          "label-medium": {
            "fontFamily": "Roboto",
            "fontWeight": "500",
            "fontSize": 12,
            "lineHeight": 16,
            "letterSpacing": 0.5,
          },
          "label-small": {
            "fontFamily": "Roboto",
            "fontWeight": "500",
            "fontSize": 11,
            "lineHeight": 16,
            "letterSpacing": 0.5,
          },
          "body-large": {
            "fontFamily": "Roboto",
            "fontWeight": "400",
            "fontSize": 16,
            "lineHeight": 24,
            "letterSpacing": 0.5,
          },
          "body-medium": {
            "fontFamily": "Roboto",
            "fontWeight": "400",
            "fontSize": 14,
            "lineHeight": 20,
            "letterSpacing": 0.25,
          },
          "body-small": {
            "fontFamily": "Roboto",
            "fontWeight": "400",
            "fontSize": 12,
            "lineHeight": 16,
            "letterSpacing": 0.4,
          },
        },
      },
    };
    final fontsMap = {
      "fonts": [
        {
          "family": "Roboto",
          "fonts": [
            {"asset": "assets/fonts/Roboto-Regular.ttf"},
          ],
        },
      ],
    };

    test('parses JSON correctly', () {
      final texts = Texts.fromJson(textStylesMap, fontsMap);
      final style = texts.displayLarge;
      expect(style.fontFamily, 'Roboto');
      expect(style.fontSize, 57.0);
      expect(style.fontWeight, FontWeight.w400);
      expect(style.letterSpacing, -0.25);
    });

    test('textTheme returns correct TextTheme', () {
      final texts = Texts.fromJson(textStylesMap, fontsMap);
      final theme = texts.textTheme();
      expect(theme.displayLarge?.fontSize, 57.0);
      expect(theme.bodyMedium?.fontSize, 14.0);
    });
  });
}
