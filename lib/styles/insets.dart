import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

@immutable
class Insets {
  final double _scale;
  final Map<String, dynamic> _insetConfigs;

  const Insets._(this._scale, this._insetConfigs);

  factory Insets.fromJson(Map<String, dynamic> json, {double scale = 1.0}) {
    final defaults = {
      'xxs': 4.0,
      'xs': 8.0,
      'sm': 16.0,
      'md': 24.0,
      'lg': 32.0,
      'xl': 48.0,
      'xxl': 56.0,
      'offset': 80.0,
    };

    final insetsRaw = json['insets'];
    final config = insetsRaw != null
        ? {...defaults, ...Map<String, dynamic>.from(insetsRaw as Map)}
        : defaults;
    return Insets._(scale, config);
  }

  double get xxs => (_insetConfigs['xxs'] as num).toDouble() * _scale;

  double get xs => (_insetConfigs['xs'] as num).toDouble() * _scale;

  double get sm => (_insetConfigs['sm'] as num).toDouble() * _scale;

  double get md => (_insetConfigs['md'] as num).toDouble() * _scale;

  double get lg => (_insetConfigs['lg'] as num).toDouble() * _scale;

  double get xl => (_insetConfigs['xl'] as num).toDouble() * _scale;

  double get xxl => (_insetConfigs['xxl'] as num).toDouble() * _scale;

  double get offset => (_insetConfigs['offset'] as num).toDouble() * _scale;

  /// Optionally get any inset by key
  double inset(String key) {
    final value = _insetConfigs[key];
    if (value is num) return value.toDouble() * _scale;
    throw Exception('Inset key "$key" not found or is not a number');
  }
}
