import 'dart:ui';
import 'package:my_theme_style/my_theme_style.dart';
import 'package:my_theme_style/utils/color_utils.dart';

/// Helper class to access custom color groups
class CustomColorGroup {
  final Map<String, dynamic> _config;

  CustomColorGroup(this._config);

  /// Get a color by key for the current theme
  Color color(String key) {
    final theme = MyThemeStyle.currentTheme;
    final colorData = _config[key];

    if (colorData == null) {
      throw Exception('Custom color key "$key" not found.');
    }

    if (colorData is Map) {
      final hex = colorData[theme];
      if (hex != null) {
        return ColorUtils.parseColor(hex.toString());
      }
    }

    throw Exception('Custom color "$key" not defined for theme "$theme".');
  }

  /// Allow dynamic property access (e.g. .orange)
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isGetter) {
      final key = invocation.memberName.toString().split('"')[1];
      // Try to find the key in the config
      if (_config.containsKey(key)) {
        return color(key);
      }
    }
    return super.noSuchMethod(invocation);
  }
}
