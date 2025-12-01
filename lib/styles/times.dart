import 'package:flutter/material.dart';
import 'package:flutter_core/core/extensions/duration_utils.dart';

@immutable
class Times {
  final Map<String, dynamic> _durationConfigs;
  final Map<String, dynamic> _easingConfigs;

  const Times._(this._durationConfigs, this._easingConfigs);

  factory Times.fromJson(Map<String, dynamic> json) {
    final durationDefaults = {
      'short1': 50,
      'short2': 100,
      'short3': 150,
      'short4': 200,
      'medium1': 250,
      'medium2': 300,
      'medium3': 350,
      'medium4': 400,
      'long1': 450,
      'long2': 500,
      'long3': 550,
      'long4': 600,
      'extraLong1': 700,
      'extraLong2': 800,
      'extraLong3': 900,
      'extraLong4': 1000,
      'pageTransition': 1000,
    };

    final easingDefaults = {
      'standard': 'Cubic(0.2, 0.0, 0.0, 1.0)',
      'standardAccelerate': 'Cubic(0.3, 0.0, 1.0, 1.0)',
      'standardDecelerate': 'Cubic(0.0, 0.0, 0.0, 1.0)',
      'emphasized': 'Cubic(0.2, 0.0, 0.0, 1.0)',
      'emphasizedAccelerate': 'Cubic(0.3, 0.0, 0.8, 0.15)',
      'emphasizedDecelerate': 'Cubic(0.05, 0.7, 0.1, 1.0)',
    };

    final durationsRaw = json['durations'];
    final easingsRaw = json['easings'];

    final durationConfig = durationsRaw != null
        ? {
            ...durationDefaults,
            ...Map<String, dynamic>.from(durationsRaw as Map),
          }
        : durationDefaults;

    final easingConfig = easingsRaw != null
        ? {...easingDefaults, ...Map<String, dynamic>.from(easingsRaw as Map)}
        : easingDefaults;

    return Times._(durationConfig, easingConfig);
  }

  Duration get short1 => (_durationConfigs['short1'] as int).animateMs;

  Duration get short2 => (_durationConfigs['short2'] as int).animateMs;

  Duration get short3 => (_durationConfigs['short3'] as int).animateMs;

  Duration get short4 => (_durationConfigs['short4'] as int).animateMs;

  Duration get medium1 => (_durationConfigs['medium1'] as int).animateMs;

  Duration get medium2 => (_durationConfigs['medium2'] as int).animateMs;

  Duration get medium3 => (_durationConfigs['medium3'] as int).animateMs;

  Duration get medium4 => (_durationConfigs['medium4'] as int).animateMs;

  Duration get long1 => (_durationConfigs['long1'] as int).animateMs;

  Duration get long2 => (_durationConfigs['long2'] as int).animateMs;

  Duration get long3 => (_durationConfigs['long3'] as int).animateMs;

  Duration get long4 => (_durationConfigs['long4'] as int).animateMs;

  Duration get extraLong1 => (_durationConfigs['extraLong1'] as int).animateMs;

  Duration get extraLong2 => (_durationConfigs['extraLong2'] as int).animateMs;

  Duration get extraLong3 => (_durationConfigs['extraLong3'] as int).animateMs;

  Duration get extraLong4 => (_durationConfigs['extraLong4'] as int).animateMs;

  Duration get pageTransition =>
      (_durationConfigs['extraLong4'] as int).animateMs;

  Curve get standard => _parseCurve(_easingConfigs['standard']);

  Curve get standardAccelerate =>
      _parseCurve(_easingConfigs['standardAccelerate']);

  Curve get standardDecelerate =>
      _parseCurve(_easingConfigs['standardDecelerate']);

  Curve get emphasized => _parseCurve(_easingConfigs['emphasized']);

  Curve get emphasizedAccelerate =>
      _parseCurve(_easingConfigs['emphasizedAccelerate']);

  Curve get emphasizedDecelerate =>
      _parseCurve(_easingConfigs['emphasizedDecelerate']);

  /// Optionally, get a duration by key
  Duration duration(String key) {
    final ms = _durationConfigs[key];
    if (ms is int) return ms.animateMs;
    throw Exception('Duration key "$key" not found or is not int');
  }

  Curve _parseCurve(String? curveString) {
    if (curveString == null) return Curves.linear;
    if (curveString.startsWith('Cubic(') && curveString.endsWith(')')) {
      final params = curveString
          .substring(6, curveString.length - 1)
          .split(',');
      if (params.length == 4) {
        return Cubic(
          double.parse(params[0].trim()),
          double.parse(params[1].trim()),
          double.parse(params[2].trim()),
          double.parse(params[3].trim()),
        );
      }
    }
    return Curves.linear;
  }
}
