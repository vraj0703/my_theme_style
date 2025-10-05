import 'package:flutter/material.dart';
import 'package:my_theme_style/styles/colors.dart';

import 'corners.dart';
import 'insets.dart';
import 'shadows.dart';
import 'sizes.dart';
import 'texts.dart';
import 'times.dart';

export 'colors.dart';

@immutable
class AppStyle {
  late final double scale;
  late final bool disableAnimations;
  late final bool highContrast;
  late final Map<String, dynamic> colorsMap;
  late final Map<String, dynamic> cornersMap;
  late final Map<String, dynamic> shadowsMap;
  late final Map<String, dynamic> insetsMap;
  late final Map<String, dynamic> textsMap;
  late final Map<String, dynamic> timesMap;
  late final Map<String, dynamic> sizesMap;

  /// The current theme colors for the app
  late final AppColors colors = AppColors.fromJson(colorsMap);

  /// Rounded edge corner radii
  late final Corners corners = Corners.fromJson(cornersMap);

  late final Shadows shadows = Shadows.fromJson(shadowsMap);

  /// Padding and margin values
  late final Insets insets = Insets.fromJson(insetsMap, scale: scale);

  /// Text styles
  late final Texts text = Texts.fromJson(textsMap, scale: scale);

  /// Animation Durations
  late final Times times = Times.fromJson(timesMap);

  /// Shared sizes
  late final Sizes sizes = Sizes.fromJson(sizesMap);

  AppStyle({
    Size? screenSize,
    this.disableAnimations = false,
    this.highContrast = false,
    this.colorsMap = const {},
    this.cornersMap = const {},
    this.shadowsMap = const {},
    this.insetsMap = const {},
    this.textsMap = const {},
    this.timesMap = const {},
    this.sizesMap = const {},
  }) {
    if (screenSize == null) {
      scale = 1;
      return;
    }
    final shortestSide = screenSize.shortestSide;
    const tabletXl = 1000;
    const tabletLg = 800;
    if (shortestSide > tabletXl) {
      scale = 1.2;
    } else if (shortestSide > tabletLg) {
      scale = 1.1;
    } else {
      scale = 1;
    }
  }

  ThemeData themeData({String theme = 'light'}) {
    final colorScheme = colors.materialColorScheme(theme);
    final textTheme = text.textTheme();
    // You can add customizations here using corners, insets, shadows, etc.
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,
      useMaterial3: true,
      // Example: Override default shadow for AppBar using shadows
      appBarTheme: AppBarTheme(shadowColor: colors.color(theme, 'shadow')),
    );
  }
}
