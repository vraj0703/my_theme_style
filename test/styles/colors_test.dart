import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_theme_style/styles/colors.dart';

void main() {
  group('AppColors', () {
    final schemeConfig = {
      "schemes": {
        "light": {
          "primary": "#6750A4",
          "onPrimary": "#FFFFFF",
          "primaryContainer": "#EADDFF",
          "onPrimaryContainer": "#21005D",
          "secondary": "#625B71",
          "onSecondary": "#FFFFFF",
          "secondaryContainer": "#E8DEF8",
          "onSecondaryContainer": "#1D192B",
          "tertiary": "#7D5260",
          "onTertiary": "#FFFFFF",
          "tertiaryContainer": "#FFD8E4",
          "onTertiaryContainer": "#31111D",
          "error": "#B3261E",
          "onError": "#FFFFFF",
          "errorContainer": "#F9DEDC",
          "onErrorContainer": "#410E0B",
          "background": "#FFFBFE",
          "onBackground": "#1C1B1F",
          "surface": "#FFFBFE",
          "onSurface": "#1C1B1F",
          "surfaceVariant": "#E7E0EC",
          "onSurfaceVariant": "#49454F",
          "outline": "#79747E",
          "outlineVariant": "#CAC4D0",
          "shadow": "#000000",
          "scrim": "#000000",
          "inverseSurface": "#313033",
          "inverseOnSurface": "#F4EFF4",
          "inversePrimary": "#D0BCFF",
          "surfaceTint": "#6750A4",
        },
        "dark": {
          "primary": "#D0BCFF",
          "onPrimary": "#381E72",
          "primaryContainer": "#4F378B",
          "onPrimaryContainer": "#EADDFF",
          "secondary": "#CCC2DC",
          "onSecondary": "#332D41",
          "secondaryContainer": "#4A4458",
          "onSecondaryContainer": "#E8DEF8",
          "tertiary": "#EFB8C8",
          "onTertiary": "#492532",
          "tertiaryContainer": "#633B48",
          "onTertiaryContainer": "#FFD8E4",
          "error": "#F2B8B5",
          "onError": "#601410",
          "errorContainer": "#8C1D18",
          "onErrorContainer": "#F9DEDC",
          "background": "#1C1B1F",
          "onBackground": "#E6E1E5",
          "surface": "#1C1B1F",
          "onSurface": "#E6E1E5",
          "surfaceVariant": "#49454F",
          "onSurfaceVariant": "#CAC4D0",
          "outline": "#938F99",
          "outlineVariant": "#49454F",
          "shadow": "#000000",
          "scrim": "#000000",
          "inverseSurface": "#E6E1E5",
          "inverseOnSurface": "#313033",
          "inversePrimary": "#6750A4",
          "surfaceTint": "#D0BCFF",
        },
      },
    };
    final baseColors = {
      "base": {"white": "#FFFFFF", "black": "#000000"},
    };

    test('parses JSON correctly', () {
      final appColors = AppColors.fromJson(schemeConfig, baseColors);
      expect(appColors.primaryLight, const Color(0xFF6750A4));
      expect(appColors.onPrimaryLight, const Color(0xFFFFFFFF));
      expect(appColors.primaryDark, const Color(0xFFD0BCFF));
      expect(appColors.onPrimaryDark, const Color(0xFF381E72));
      expect(appColors.white, const Color(0xFFFFFFFF));
      expect(appColors.black, const Color(0xFF000000));
    });

    test('materialColorScheme returns correct scheme', () {
      final appColors = AppColors.fromJson(schemeConfig, baseColors);
      final lightScheme = appColors.materialColorScheme('light');
      expect(lightScheme.brightness, Brightness.light);
      expect(lightScheme.primary, const Color(0xFF6750A4));

      final darkScheme = appColors.materialColorScheme('dark');
      expect(darkScheme.brightness, Brightness.dark);
      expect(darkScheme.primary, const Color(0xFFD0BCFF));
    });

    test('throws on missing key', () {
      final appColors = AppColors.fromJson(schemeConfig, baseColors);
      expect(() => appColors.color('light', 'missing'), throwsException);
    });
  });
}
