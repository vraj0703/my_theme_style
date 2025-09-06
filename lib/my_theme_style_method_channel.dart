import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_theme_style_platform_interface.dart';

/// An implementation of [MyThemeStylePlatform] that uses method channels.
class MethodChannelMyThemeStyle extends MyThemeStylePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_theme_style');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
