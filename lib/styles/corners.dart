import 'package:flutter/material.dart';

@immutable
class Corners {
  final Map<String, dynamic> _cornerConfigs;

  const Corners._(this._cornerConfigs);

  factory Corners.fromJson(Map<String, dynamic> json) {
    final defaults = {
      'none': 0.0,
      'exsm': 4.0,
      'sm': 8.0,
      'md': 12.0,
      'lg': 16.0,
      'exlg': 28.0,
      'full': 1000.0,
    };

    final cornersRaw = json['radius'];
    final config = cornersRaw != null
        ? {...defaults, ...Map<String, dynamic>.from(cornersRaw as Map)}
        : defaults;

    return Corners._(config);
  }

  double get none => (_cornerConfigs['none'] as num).toDouble();
  double get exsm => (_cornerConfigs['exsm'] as num).toDouble();
  double get sm => (_cornerConfigs['sm'] as num).toDouble();
  double get md => (_cornerConfigs['md'] as num).toDouble();
  double get lg => (_cornerConfigs['lg'] as num).toDouble();
  double get exlg => (_cornerConfigs['exlg'] as num).toDouble();
  double get full => (_cornerConfigs['full'] as num).toDouble();

  /// Optionally get any corner by key
  double corner(String key) {
    final value = _cornerConfigs[key];
    if (value is num) return value.toDouble();
    throw Exception('Corner key "$key" not found or is not a number');
  }
}
