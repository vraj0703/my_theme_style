import 'package:flutter/foundation.dart';
import 'package:flutter_core/core/extensions/duration_utils.dart';

@immutable
class Times {
  final Map<String, dynamic> _durationConfigs;

  const Times._(this._durationConfigs);

  factory Times.fromJson(Map<String, dynamic> json) {
    final defaults = {
      'fast': 300,
      'med': 600,
      'slow': 900,
      'extraSlow': 1300,
      'pageTransition': 200,
    };

    final durationsRaw = json['durations'];
    final config = durationsRaw != null
        ? {...defaults, ...Map<String, dynamic>.from(durationsRaw as Map)}
        : defaults;

    return Times._(config);
  }

  Duration get fast => (_durationConfigs['fast'] as int).animateMs;

  Duration get med => (_durationConfigs['med'] as int).animateMs;

  Duration get slow => (_durationConfigs['slow'] as int).animateMs;

  Duration get extraSlow => (_durationConfigs['extraSlow'] as int).animateMs;

  Duration get pageTransition =>
      (_durationConfigs['pageTransition'] as int).animateMs;

  /// Optionally, get a duration by key (e.g. for custom animations)
  Duration duration(String key) {
    final ms = _durationConfigs[key];
    if (ms is int) return ms.animateMs;
    throw Exception('Duration key "$key" not found or is not int');
  }
}
