import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_theme_style_method_channel.dart';

abstract class MyThemeStylePlatform extends PlatformInterface {
  /// Constructs a MyThemeStylePlatform.
  MyThemeStylePlatform() : super(token: _token);

  static final Object _token = Object();

  static MyThemeStylePlatform _instance = MethodChannelMyThemeStyle();

  /// The default instance of [MyThemeStylePlatform] to use.
  ///
  /// Defaults to [MethodChannelMyThemeStyle].
  static MyThemeStylePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyThemeStylePlatform] when
  /// they register themselves.
  static set instance(MyThemeStylePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
