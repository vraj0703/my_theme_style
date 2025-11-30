import 'package:flutter/material.dart';
import 'colors.dart';

import 'corners.dart';
import 'insets.dart';
import 'shadows.dart';
import 'sizes.dart';
import 'texts.dart';
import 'times.dart';

import 'gradients.dart';

export 'colors.dart';
export 'gradients.dart';

@immutable
class AppStyle {
  late final double scale;
  late final bool disableAnimations;
  late final bool highContrast;
  late final Map<String, dynamic> colorsMap;
  late final Map<String, dynamic> gradientsMap;
  late final Map<String, dynamic> cornersMap;
  late final Map<String, dynamic> shadowsMap;
  late final Map<String, dynamic> insetsMap;
  late final Map<String, dynamic> textStylesMap;
  late final Map<String, dynamic> timesMap;
  late final Map<String, dynamic> sizesMap;
  late final Map<String, dynamic> fontsMap;

  /// The current theme colors for the app
  late final AppColors colors = AppColors.fromJson(colorsMap);

  /// The current theme gradients for the app
  late final AppGradients gradients = AppGradients.fromJson(gradientsMap);

  /// Rounded edge corner radii
  late final Corners corners = Corners.fromJson(cornersMap);

  late final Shadows shadows = Shadows.fromJson(shadowsMap);

  /// Padding and margin values
  late final Insets insets = Insets.fromJson(insetsMap, scale: scale);

  /// Text styles
  late final Texts text = Texts.fromJson(textStylesMap, fontsMap, scale: scale);

  /// Animation Durations
  late final Times times = Times.fromJson(timesMap);

  /// Shared sizes
  late final Sizes sizes = Sizes.fromJson(sizesMap);

  AppStyle({
    Size? screenSize,
    this.disableAnimations = false,
    this.highContrast = false,
    this.colorsMap = const {},
    this.gradientsMap = const {},
    this.cornersMap = const {},
    this.shadowsMap = const {},
    this.insetsMap = const {},
    this.textStylesMap = const {},
    this.timesMap = const {},
    this.sizesMap = const {},
    this.fontsMap = const {}
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
