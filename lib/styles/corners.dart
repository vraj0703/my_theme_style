import 'package:flutter/material.dart';

@immutable
class Corners {
  final Map<String, dynamic> _cornerConfigs;

  const Corners._(this._cornerConfigs);

  factory Corners.fromJson(Map<String, dynamic> json) {
    final defaults = {'sm': 4.0, 'md': 16.0, 'lg': 32.0};

    final cornersRaw = json['corners'];
    final config = cornersRaw != null
        ? {...defaults, ...Map<String, dynamic>.from(cornersRaw as Map)}
        : defaults;

    return Corners._(config);
  }

  double get sm => (_cornerConfigs['sm'] as num).toDouble();

  double get md => (_cornerConfigs['md'] as num).toDouble();

  double get lg => (_cornerConfigs['lg'] as num).toDouble();

  /// Optionally get any corner by key
  double corner(String key) {
    final value = _cornerConfigs[key];
    if (value is num) return value.toDouble();
    throw Exception('Corner key "$key" not found or is not a number');
  }
}
