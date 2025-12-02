import 'package:flutter/material.dart';
import 'package:my_theme_style/my_theme_style.dart';
import 'package:my_theme_style/utils/color_utils.dart';

class AppGradients {
  final Map<String, dynamic> _config;

  AppGradients(this._config);

  factory AppGradients.fromJson(Map<String, dynamic> json) {
    return AppGradients(json);
  }

  Gradient? get primary => gradient('primary');

  Gradient? get surface => gradient('surface');

  Gradient? gradient(String key) {
    final theme = MyThemeStyle.currentTheme;
    final config = _config[key];

    if (config == null) return null;

    // Check for theme-specific config
    if (config is Map &&
        (config.containsKey('light') || config.containsKey('dark'))) {
      final themeConfig = config[theme];
      if (themeConfig != null) {
        return _parseGradient(themeConfig);
      }
      // Fallback to light if current theme is missing
      if (config.containsKey('light')) {
        return _parseGradient(config['light']);
      }
    }

    // Assume it's a direct gradient definition
    return _parseGradient(config);
  }

  Gradient? _parseGradient(dynamic config) {
    if (config is! Map) return null;

    final type = config['type'] as String?;

    List<Color>? colors;
    List<double>? stops;

    final rawColors = config['colors'] as List?;
    if (rawColors != null) {
      if (rawColors.any((c) => c is Map)) {
        colors = [];
        stops = [];
        for (var item in rawColors) {
          if (item is Map) {
            colors.add(ColorUtils.parseColor(item['color'].toString()));
            if (item['stop'] != null) {
              stops.add((item['stop'] as num).toDouble());
            }
          } else {
            colors.add(ColorUtils.parseColor(item.toString()));
          }
        }
        // Ensure stops match colors length, otherwise ignore stops
        if (stops.length != colors.length) {
          stops = null;
        }
      } else {
        colors = rawColors
            .map((c) => ColorUtils.parseColor(c.toString()))
            .toList();
        stops = (config['stops'] as List?)
            ?.map((s) => (s as num).toDouble())
            .toList();
      }
    }

    final tileMode = _parseTileMode(config['tileMode'] as String?);

    if (colors == null || colors.isEmpty) return null;

    switch (type) {
      case 'linear':
        return LinearGradient(
          colors: colors,
          stops: stops,
          begin:
              _parseAlignment(config['begin'] as String?) ??
              Alignment.centerLeft,
          end:
              _parseAlignment(config['end'] as String?) ??
              Alignment.centerRight,
          tileMode: tileMode,
        );
      case 'radial':
        return RadialGradient(
          colors: colors,
          stops: stops,
          center:
              _parseAlignment(config['center'] as String?) ?? Alignment.center,
          radius: (config['radius'] as num?)?.toDouble() ?? 0.5,
          tileMode: tileMode,
        );
      case 'sweep':
        return SweepGradient(
          colors: colors,
          stops: stops,
          center:
              _parseAlignment(config['center'] as String?) ?? Alignment.center,
          startAngle: (config['startAngle'] as num?)?.toDouble() ?? 0.0,
          endAngle: (config['endAngle'] as num?)?.toDouble() ?? 6.28318530718,
          // 2 * pi
          tileMode: tileMode,
        );
      default:
        return null;
    }
  }

  Alignment? _parseAlignment(String? value) {
    switch (value) {
      case 'topLeft':
        return Alignment.topLeft;
      case 'topCenter':
        return Alignment.topCenter;
      case 'topRight':
        return Alignment.topRight;
      case 'centerLeft':
        return Alignment.centerLeft;
      case 'center':
        return Alignment.center;
      case 'centerRight':
        return Alignment.centerRight;
      case 'bottomLeft':
        return Alignment.bottomLeft;
      case 'bottomCenter':
        return Alignment.bottomCenter;
      case 'bottomRight':
        return Alignment.bottomRight;
      default:
        return null;
    }
  }

  TileMode _parseTileMode(String? value) {
    switch (value) {
      case 'repeated':
        return TileMode.repeated;
      case 'mirror':
        return TileMode.mirror;
      case 'decal':
        return TileMode.decal;
      case 'clamp':
      default:
        return TileMode.clamp;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isGetter) {
      final key = invocation.memberName.toString().split('"')[1];
      if (_config.containsKey(key)) {
        return gradient(key);
      }
    }
    return super.noSuchMethod(invocation);
  }
}
