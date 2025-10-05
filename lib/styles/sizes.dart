import 'package:flutter/material.dart';

@immutable
class Sizes {
  final Map<String, dynamic> _sizeConfigs;

  const Sizes._(this._sizeConfigs);

  factory Sizes.fromJson(Map<String, dynamic> json) {
    // Defaults for all sizes
    final defaults = {
      'maxContentWidth1': 800.0,
      'maxContentWidth2': 600.0,
      'maxContentWidth3': 500.0,
      'minAppSize': {'width': 380.0, 'height': 650.0},
    };

    final sizesRaw = json['sizes'];
    // Merge defaults and config, ensure types
    final config = sizesRaw != null
        ? {...defaults, ...Map<String, dynamic>.from(sizesRaw as Map)}
        : defaults;

    return Sizes._(config);
  }

  double get maxContentWidth1 =>
      (_sizeConfigs['maxContentWidth1'] as num).toDouble();

  double get maxContentWidth2 =>
      (_sizeConfigs['maxContentWidth2'] as num).toDouble();

  double get maxContentWidth3 =>
      (_sizeConfigs['maxContentWidth3'] as num).toDouble();

  Size get minAppSize {
    final minSize = _sizeConfigs['minAppSize'];
    if (minSize is Map) {
      final width = (minSize['width'] as num).toDouble();
      final height = (minSize['height'] as num).toDouble();
      return Size(width, height);
    }
    // fallback
    return const Size(380, 650);
  }

  /// Optionally get any size by key
  double size(String key) {
    final value = _sizeConfigs[key];
    if (value is num) return value.toDouble();
    throw Exception('Size key "$key" not found or is not a number');
  }
}
