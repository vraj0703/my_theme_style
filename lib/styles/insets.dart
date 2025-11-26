import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

@immutable
class Insets {
  final double _scale;
  final Map<String, dynamic> _insetConfigs;

  const Insets._(this._scale, this._insetConfigs);

  factory Insets.fromJson(Map<String, dynamic> json, {double scale = 1.0}) {
    final defaults = {
      'xs': 4.0,
      'sm': 8.0,
      'md': 16.0,
      'lg': 24.0,
      'xl': 32.0,
      'xxl': 48.0,
    };

    final insetsRaw = json['padding'];
    final config = insetsRaw != null
        ? {...defaults, ...Map<String, dynamic>.from(insetsRaw as Map)}
        : defaults;
    return Insets._(scale, config);
  }

  double get xs => (_insetConfigs['xs'] as num).toDouble() * _scale;
  double get sm => (_insetConfigs['sm'] as num).toDouble() * _scale;
  double get md => (_insetConfigs['md'] as num).toDouble() * _scale;
  double get lg => (_insetConfigs['lg'] as num).toDouble() * _scale;
  double get xl => (_insetConfigs['xl'] as num).toDouble() * _scale;
  double get xxl => (_insetConfigs['xxl'] as num).toDouble() * _scale;

  /// Optionally get any inset by key
  double inset(String key) {
    final value = _insetConfigs[key];
    if (value is num) return value.toDouble() * _scale;
    throw Exception('Inset key "$key" not found or is not a number');
  }
}
