import 'package:flutter/material.dart';

@immutable
class AppColors {
  final Map<String, dynamic> _schemeConfigs;

  const AppColors._(this._schemeConfigs);

  factory AppColors.fromJson(Map<String, dynamic> json) {
    final defaults = {"light": {}, "dark": {}};

    final config = {...defaults, ...Map<String, dynamic>.from(json)};
    return AppColors._(config);
  }

  /// Get a color value from the color scheme ('light' or 'dark')
  Color color(String scheme, String key, {Color? fallback}) {
    final value = _get(scheme, key);
    if (value is String) return _parseColor(value);
    if (fallback != null) return fallback;
    throw Exception('Color key "$key" not found in scheme "$scheme"');
  }

  /// Get entire palette (returns Map<String, Color>)
  Map<String, Color> palette(String scheme, String paletteKey) {
    final palette = _get(scheme, paletteKey);
    if (palette is Map && palette['tones'] is Map) {
      return (palette['tones'] as Map<String, dynamic>).map(
        (tone, hex) => MapEntry(tone, _parseColor(hex as String)),
      );
    }
    throw Exception('Palette key "$paletteKey" not found in scheme "$scheme"');
  }

  /// Get the source color HCT as a Map with hue, chroma, tone
  Map<String, double> sourceColorHct(String scheme) {
    final hct = _get(scheme, 'source_color_hct');
    if (hct is Map) {
      return {
        "hue": (hct['hue'] as num?)?.toDouble() ?? 0.0,
        "chroma": (hct['chroma'] as num?)?.toDouble() ?? 0.0,
        "tone": (hct['tone'] as num?)?.toDouble() ?? 0.0,
      };
    }
    throw Exception('source_color_hct not found in scheme "$scheme"');
  }

  /// Get all palettes as maps of tone to Color
  Map<String, Color> getPrimaryPalette(String scheme) =>
      palette(scheme, 'primary_palette');

  Map<String, Color> getSecondaryPalette(String scheme) =>
      palette(scheme, 'secondary_palette');

  Map<String, Color> getTertiaryPalette(String scheme) =>
      palette(scheme, 'tertiary_palette');

  Map<String, Color> getNeutralPalette(String scheme) =>
      palette(scheme, 'neutral_palette');

  Map<String, Color> getNeutralVariantPalette(String scheme) =>
      palette(scheme, 'neutral_variant_palette');

  Map<String, Color> getErrorPalette(String scheme) =>
      palette(scheme, 'error_palette');

  /// Example getters for common M3 color roles
  Color get primaryLight => color('light', 'primary');

  Color get onPrimaryLight => color('light', 'on_primary');

  Color get primaryContainerLight => color('light', 'primary_container');

  Color get backgroundLight => color('light', 'background');

  Color get surfaceLight => color('light', 'surface');

  Color get primaryDark => color('dark', 'primary');

  Color get onPrimaryDark => color('dark', 'on_primary');

  Color get primaryContainerDark => color('dark', 'primary_container');

  Color get backgroundDark => color('dark', 'background');

  Color get surfaceDark => color('dark', 'surface');

  /// Get a full color scheme (returns MaterialColorScheme)
  ColorScheme materialColorScheme(String scheme) {
    Color get(String key, {Color? fallback}) =>
        color(scheme, key, fallback: fallback);
    return ColorScheme(
      brightness: scheme == 'dark' ? Brightness.dark : Brightness.light,
      primary: get('primary'),
      onPrimary: get('on_primary'),
      primaryContainer: get('primary_container'),
      onPrimaryContainer: get('on_primary_container'),
      secondary: get('secondary'),
      onSecondary: get('on_secondary'),
      secondaryContainer: get('secondary_container'),
      onSecondaryContainer: get('on_secondary_container'),
      tertiary: get('tertiary'),
      onTertiary: get('on_tertiary'),
      tertiaryContainer: get('tertiary_container'),
      onTertiaryContainer: get('on_tertiary_container'),
      error: get('error'),
      onError: get('on_error'),
      errorContainer: get('error_container'),
      onErrorContainer: get('on_error_container'),
      background: get('background'),
      onBackground: get('on_surface'),
      // Sometimes on_background, fallback to on_surface
      surface: get('surface'),
      onSurface: get('on_surface'),
      surfaceVariant: get('surface_variant'),
      onSurfaceVariant: get('on_surface_variant'),
      outline: get('outline'),
      shadow: get('shadow', fallback: Colors.black),
      inverseSurface: get('inverse_surface'),
      inversePrimary: get('inverse_primary'),
      scrim: get('scrim', fallback: Colors.black),
      surfaceTint: get('surface_tint'),
    );
  }

  /// Helper to parse a color string like "#ff0000" or "#FFF8F6" to [Color]
  Color _parseColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex'; // Add full opacity
    return Color(int.parse(hex, radix: 16));
  }

  /// Get value from scheme ('light' or 'dark'), return hex string or fallback
  dynamic _get(String scheme, String key) =>
      (_schemeConfigs[scheme] != null && _schemeConfigs[scheme][key] != null)
      ? _schemeConfigs[scheme][key]
      : null;
}
