import 'package:flutter/material.dart';

@immutable
class Corners {
  final Map<String, dynamic> _cornerConfigs;

  const Corners._(this._cornerConfigs);

  factory Corners.fromJson(Map<String, dynamic> json) {
    final defaults = {
      'none': 0.0,
      'extraSmall': 4.0,
      'small': 8.0,
      'medium': 12.0,
      'large': 16.0,
      'extraLarge': 28.0,
      'full': 1000.0,
    };

    final cornersRaw = json['radius'];
    final config = cornersRaw != null
        ? {...defaults, ...Map<String, dynamic>.from(cornersRaw as Map)}
        : defaults;

    return Corners._(config);
  }

  double get none => (_cornerConfigs['none'] as num).toDouble();
  double get extraSmall => (_cornerConfigs['extraSmall'] as num).toDouble();
  double get small => (_cornerConfigs['small'] as num).toDouble();
  double get medium => (_cornerConfigs['medium'] as num).toDouble();
  double get large => (_cornerConfigs['large'] as num).toDouble();
  double get extraLarge => (_cornerConfigs['extraLarge'] as num).toDouble();
  double get full => (_cornerConfigs['full'] as num).toDouble();

  /// Optionally get any corner by key
  double corner(String key) {
    final value = _cornerConfigs[key];
    if (value is num) return value.toDouble();
    throw Exception('Corner key "$key" not found or is not a number');
  }
}
