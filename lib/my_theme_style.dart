
import 'package:my_localizations/library.dart';

import 'my_theme_style_platform_interface.dart';

class MyThemeStyle {
  static late LocaleLogic _localeLogic;
  static late String _localeName;

  static Future<void> initialize({
    required LocaleLogic localeLogic,
    required String localeName,
  }) async {
    _localeLogic = localeLogic;
    _localeName = localeName;
  }

  static LocaleLogic get localeLogic => _localeLogic;
  static String get localeName => _localeName;

  Future<String?> getPlatformVersion() {
    return MyThemeStylePlatform.instance.getPlatformVersion();
  }
}
