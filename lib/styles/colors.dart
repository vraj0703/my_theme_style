import 'package:flutter/material.dart';
import 'package:my_theme_style/styles/custom_color_group.dart';

@immutable
class AppColors {
  final Map<String, dynamic> _schemeConfigs;
  final Map<String, dynamic> _baseColors;
  final Map<String, dynamic> _customConfigs;

  const AppColors._(this._schemeConfigs, this._baseColors, this._customConfigs);

  factory AppColors.fromJson(Map<String, dynamic> data) {
    final config = Map<String, dynamic>.from(data as Map);
    final schemes = config['schemes'] ?? {};
    final base = config['base'] ?? {};
    final custom = config['custom'] ?? {};
    return AppColors._(schemes, base, custom);
  }

  /// Get a custom color group by name
  CustomColorGroup custom(String groupName) {
    final groupConfig = _customConfigs[groupName];
    if (groupConfig == null) {
      throw Exception('Custom color group "$groupName" not found.');
    }
    return CustomColorGroup(groupConfig);
  }

  /// Get a color value from the color scheme ('light' or 'dark')
  Color color(String scheme, String key, {Color? fallback}) {
    final value = _get(scheme, key);
    // print('DEBUG: scheme=$scheme, key=$key, value=$value');
    if (value is String) return _parseColor(value);
    if (fallback != null) return fallback;
    // Return transparent or throw? Throwing helps debug.
    throw Exception('Color key "$key" not found in scheme "$scheme"');
  }

  /// Get entire palette (returns Map<String, Color>)
  Map<String, Color> palette(String scheme, String paletteKey) {
    // M3 doesn't strictly define palettes in the same way as M2 (swatches),
    // but if we have them in JSON we can support them.
    // For now, we focus on the scheme roles.
    final palette = _get(scheme, paletteKey);
    if (palette is Map) {
      return palette.map(
            (k, v) => MapEntry(k.toString(), _parseColor(v.toString())),
      );
    }
    throw Exception('Palette key "$paletteKey" not found in scheme "$scheme"');
  }

  // --- Material 3 Roles ---

  Color get primaryLight => color('light', 'primary');

  Color get onPrimaryLight => color('light', 'onPrimary');

  Color get primaryContainerLight => color('light', 'primaryContainer');

  Color get onPrimaryContainerLight => color('light', 'onPrimaryContainer');

  Color get secondaryLight => color('light', 'secondary');

  Color get onSecondaryLight => color('light', 'onSecondary');

  Color get secondaryContainerLight => color('light', 'secondaryContainer');

  Color get onSecondaryContainerLight => color('light', 'onSecondaryContainer');

  Color get tertiaryLight => color('light', 'tertiary');

  Color get onTertiaryLight => color('light', 'onTertiary');

  Color get tertiaryContainerLight => color('light', 'tertiaryContainer');

  Color get onTertiaryContainerLight => color('light', 'onTertiaryContainer');

  Color get errorLight => color('light', 'error');

  Color get onErrorLight => color('light', 'onError');

  Color get errorContainerLight => color('light', 'errorContainer');

  Color get onErrorContainerLight => color('light', 'onErrorContainer');

  Color get backgroundLight => color('light', 'background');

  Color get onBackgroundLight => color('light', 'onBackground');

  Color get surfaceLight => color('light', 'surface');

  Color get onSurfaceLight => color('light', 'onSurface');

  Color get surfaceVariantLight => color('light', 'surfaceVariant');

  Color get onSurfaceVariantLight => color('light', 'onSurfaceVariant');

  Color get outlineLight => color('light', 'outline');

  Color get outlineVariantLight => color('light', 'outlineVariant');

  Color get shadowLight => color('light', 'shadow');

  Color get scrimLight => color('light', 'scrim');

  Color get inverseSurfaceLight => color('light', 'inverseSurface');

  Color get inverseOnSurfaceLight => color('light', 'inverseOnSurface');

  Color get inversePrimaryLight => color('light', 'inversePrimary');

  Color get surfaceTintLight => color('light', 'surfaceTint');

  // Dark
  Color get primaryDark => color('dark', 'primary');

  Color get onPrimaryDark => color('dark', 'onPrimary');

  Color get primaryContainerDark => color('dark', 'primaryContainer');

  Color get onPrimaryContainerDark => color('dark', 'onPrimaryContainer');

  Color get secondaryDark => color('dark', 'secondary');

  Color get onSecondaryDark => color('dark', 'onSecondary');

  Color get secondaryContainerDark => color('dark', 'secondaryContainer');

  Color get onSecondaryContainerDark => color('dark', 'onSecondaryContainer');

  Color get tertiaryDark => color('dark', 'tertiary');

  Color get onTertiaryDark => color('dark', 'onTertiary');

  Color get tertiaryContainerDark => color('dark', 'tertiaryContainer');

  Color get onTertiaryContainerDark => color('dark', 'onTertiaryContainer');

  Color get errorDark => color('dark', 'error');

  Color get onErrorDark => color('dark', 'onError');

  Color get errorContainerDark => color('dark', 'errorContainer');

  Color get onErrorContainerDark => color('dark', 'onErrorContainer');

  Color get backgroundDark => color('dark', 'background');

  Color get onBackgroundDark => color('dark', 'onBackground');

  Color get surfaceDark => color('dark', 'surface');

  Color get onSurfaceDark => color('dark', 'onSurface');

  Color get surfaceVariantDark => color('dark', 'surfaceVariant');

  Color get onSurfaceVariantDark => color('dark', 'onSurfaceVariant');

  Color get outlineDark => color('dark', 'outline');

  Color get outlineVariantDark => color('dark', 'outlineVariant');

  Color get shadowDark => color('dark', 'shadow');

  Color get scrimDark => color('dark', 'scrim');

  Color get inverseSurfaceDark => color('dark', 'inverseSurface');

  Color get inverseOnSurfaceDark => color('dark', 'inverseOnSurface');

  Color get inversePrimaryDark => color('dark', 'inversePrimary');

  Color get surfaceTintDark => color('dark', 'surfaceTint');

  // Base Colors
  Color get white => _getBaseColor('white', fallback: '#FFFFFF');

  Color get black => _getBaseColor('black', fallback: '#000000');

  Color get offWhite => _getBaseColor('offWhite', fallback: '#FAF9F6');

  Color get greyDark => _getBaseColor('greyDark', fallback: '#A9A9A9');

  Color get greyLight => _getBaseColor('greyLight', fallback: '#A9A9A9');

  Color get transparent => _getBaseColor('transparent', fallback: '#00000000');

  /// Get a full color scheme (returns MaterialColorScheme)
  ColorScheme materialColorScheme(String scheme) {
    Color get(String key, {Color? fallback}) =>
        color(scheme, key, fallback: fallback);

    final isDark = scheme == 'dark';

    return ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: get('primary'),
      onPrimary: get('onPrimary'),
      primaryContainer: get('primaryContainer'),
      onPrimaryContainer: get('onPrimaryContainer'),
      secondary: get('secondary'),
      onSecondary: get('onSecondary'),
      secondaryContainer: get('secondaryContainer'),
      onSecondaryContainer: get('onSecondaryContainer'),
      tertiary: get('tertiary'),
      onTertiary: get('onTertiary'),
      tertiaryContainer: get('tertiaryContainer'),
      onTertiaryContainer: get('onTertiaryContainer'),
      error: get('error'),
      onError: get('onError'),
      errorContainer: get('errorContainer'),
      onErrorContainer: get('onErrorContainer'),
      background: get('background'),
      onBackground: get('onBackground'),
      surface: get('surface'),
      onSurface: get('onSurface'),
      surfaceVariant: get('surfaceVariant'),
      onSurfaceVariant: get('onSurfaceVariant'),
      outline: get('outline'),
      outlineVariant: get('outlineVariant', fallback: Colors.grey),
      shadow: get('shadow', fallback: Colors.black),
      scrim: get('scrim', fallback: Colors.black),
      inverseSurface: get('inverseSurface'),
      onInverseSurface: get('inverseOnSurface'),
      inversePrimary: get('inversePrimary'),
      surfaceTint: get('surfaceTint'),
    );
  }

  /// Helper to parse a color string like "#ff0000" or "#FFF8F6" to [Color]
  Color _parseColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex'; // Add full opacity
    if (hex.length == 8) {
      return Color(int.parse(hex, radix: 16));
    }
    return const Color(0xFF000000); // Fallback
  }

  /// Get value from scheme ('light' or 'dark'), return hex string or fallback
  dynamic _get(String scheme, String key) =>
      (_schemeConfigs[scheme] != null && _schemeConfigs[scheme][key] != null)
          ? _schemeConfigs[scheme][key]
          : null;

  /// Looks up a color from the top-level of the map.
  Color _getBaseColor(String key, {required String fallback}) {
    final value = _baseColors[key] as String? ?? fallback;
    return _parseColor(value);
  }
}
