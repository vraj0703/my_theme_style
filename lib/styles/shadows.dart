import 'package:flutter/material.dart';

@immutable
class Shadows {
  final Map<String, dynamic> _shadowConfigs;

  const Shadows._(this._shadowConfigs);

  factory Shadows.fromJson(Map<String, dynamic> json) {
    // Default shadow configs (Material 3 elevations)
    // These defaults are placeholders; actual values should come from JSON or be more precise M3 values.
    final defaults = {
      'level0': {
        'color': '#000000',
        'opacity': 0.0,
        'x': 0,
        'y': 0,
        'blur': 0,
        'spread': 0,
      },
      'level1': {
        'color': '#000000',
        'opacity': 0.3,
        'x': 0,
        'y': 1,
        'blur': 2,
        'spread': 0,
      },
      'level2': {
        'color': '#000000',
        'opacity': 0.15,
        'x': 0,
        'y': 2,
        'blur': 6,
        'spread': 2,
      },
      'level3': {
        'color': '#000000',
        'opacity': 0.15,
        'x': 0,
        'y': 4,
        'blur': 8,
        'spread': 3,
      },
      'level4': {
        'color': '#000000',
        'opacity': 0.15,
        'x': 0,
        'y': 6,
        'blur': 10,
        'spread': 4,
      },
      'level5': {
        'color': '#000000',
        'opacity': 0.15,
        'x': 0,
        'y': 8,
        'blur': 12,
        'spread': 6,
      },
    };

    final shadowsRaw = json['elevation'];
    final config = shadowsRaw != null
        ? {...defaults, ...Map<String, dynamic>.from(shadowsRaw as Map)}
        : defaults;

    return Shadows._(config);
  }

  List<BoxShadow> get level0 => _buildBoxShadow('level0');
  List<BoxShadow> get level1 => _buildBoxShadow('level1');
  List<BoxShadow> get level2 => _buildBoxShadow('level2');
  List<BoxShadow> get level3 => _buildBoxShadow('level3');
  List<BoxShadow> get level4 => _buildBoxShadow('level4');
  List<BoxShadow> get level5 => _buildBoxShadow('level5');

  /// Get any shadow list by key
  List<BoxShadow> elevation(String key) => _buildBoxShadow(key);

  /// Helper to build a list of BoxShadow from config
  List<BoxShadow> _buildBoxShadow(String key) {
    final cfg = _shadowConfigs[key];
    if (cfg is Map) {
      final colorHex = cfg['color'] as String? ?? '#000000';
      final opacity = (cfg['opacity'] as num?)?.toDouble() ?? 0.0;
      final x = (cfg['x'] as num?)?.toDouble() ?? 0.0;
      final y = (cfg['y'] as num?)?.toDouble() ?? 0.0;
      final blur = (cfg['blur'] as num?)?.toDouble() ?? 0.0;
      final spread = (cfg['spread'] as num?)?.toDouble() ?? 0.0;

      final color = _parseColor(colorHex).withValues(alpha: opacity);

      return [
        BoxShadow(
          color: color,
          offset: Offset(x, y),
          blurRadius: blur,
          spreadRadius: spread,
        ),
      ];
    }
    throw Exception('Elevation key "$key" not found or is not a map');
  }

  Color _parseColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}
