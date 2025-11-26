import 'package:flutter/material.dart';

@immutable
class Sizes {
  final Map<String, dynamic> _sizeConfigs;

  const Sizes._(this._sizeConfigs);

  factory Sizes.fromJson(Map<String, dynamic> json) {
    // Start with default values.
    final defaults = {
      'icon': {'sm': 18.0, 'md': 24.0, 'lg': 32.0, 'xl': 48.0},
      'border': {'sm': 1.0, 'md': 2.0, 'lg': 4.0},
    };

    // Deep merge the JSON config over the defaults.
    final mergedConfig = deepMerge(defaults, json);

    return Sizes._(mergedConfig);
  }

  double get iconSm => _getNested('icon', 'sm');
  double get iconMd => _getNested('icon', 'md');
  double get iconLg => _getNested('icon', 'lg');
  double get iconXl => _getNested('icon', 'xl');

  double get borderSm => _getNested('border', 'sm');
  double get borderMd => _getNested('border', 'md');
  double get borderLg => _getNested('border', 'lg');

  double _getNested(String category, String key) {
    final cat = _sizeConfigs[category];
    if (cat is Map) {
      final val = cat[key];
      if (val is num) return val.toDouble();
    }
    throw Exception('Size key "$category.$key" not found');
  }

  /// Optionally get any size by key
  double size(String key) {
    final value = _sizeConfigs[key];
    if (value is num) return value.toDouble();
    throw Exception('Size key "$key" not found or is not a number');
  }
}

/// Helper to deep merge two maps. `b` has precedence over `a`.
Map<String, dynamic> deepMerge(
    Map<String, dynamic> a, Map<String, dynamic> b) {
  var result = Map<String, dynamic>.from(a);
  b.forEach((key, bValue) {
    if (a.containsKey(key)) {
      final aValue = a[key];
      if (aValue is Map<String, dynamic> && bValue is Map<String, dynamic>) {
        result[key] = deepMerge(aValue, bValue);
      } else {
        result[key] = bValue;
      }
    } else {
      result[key] = bValue;
    }
  });
  return result;
}
