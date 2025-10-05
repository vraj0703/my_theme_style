import 'package:flutter/material.dart';

@immutable
class Shadows {
  final Map<String, dynamic> _shadowConfigs;

  const Shadows._(this._shadowConfigs);

  factory Shadows.fromJson(Map<String, dynamic> json) {
    // Default shadow configs
    final defaults = {
      'textSoft': [
        {
          'color': 0xFF000000,
          'alpha': 0.25,
          'offset': {'dx': 0.0, 'dy': 2.0},
          'blurRadius': 4.0,
        },
      ],
      'text': [
        {
          'color': 0xFF000000,
          'alpha': 0.6,
          'offset': {'dx': 0.0, 'dy': 2.0},
          'blurRadius': 2.0,
        },
      ],
      'textStrong': [
        {
          'color': 0xFF000000,
          'alpha': 0.6,
          'offset': {'dx': 0.0, 'dy': 4.0},
          'blurRadius': 6.0,
        },
      ],
    };

    final shadowsRaw = json['shadows'];
    final config = shadowsRaw != null
        ? {...defaults, ...Map<String, dynamic>.from(shadowsRaw as Map)}
        : defaults;

    return Shadows._(config);
  }

  List<Shadow> get textSoft => _buildShadowList('textSoft');

  List<Shadow> get text => _buildShadowList('text');

  List<Shadow> get textStrong => _buildShadowList('textStrong');

  /// Get any shadow list by key
  List<Shadow> shadows(String key) => _buildShadowList(key);

  /// Helper to build a list of Shadow from config
  List<Shadow> _buildShadowList(String key) {
    final configList = _shadowConfigs[key];
    if (configList is List) {
      return configList.map<Shadow>((cfg) {
        final colorInt = cfg['color'] as int;
        final alpha = (cfg['alpha'] as num).toDouble();
        final offsetMap = cfg['offset'] as Map;
        final dx = (offsetMap['dx'] as num).toDouble();
        final dy = (offsetMap['dy'] as num).toDouble();
        final blurRadius = (cfg['blurRadius'] as num).toDouble();

        return Shadow(
          color: Color(colorInt).withAlpha(alpha.toInt()),
          offset: Offset(dx, dy),
          blurRadius: blurRadius,
        );
      }).toList();
    }
    throw Exception('Shadow key "$key" not found or is not a list');
  }
}
