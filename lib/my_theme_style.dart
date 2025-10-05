import 'dart:ui';
import 'package:my_localizations/library.dart';
import 'package:my_theme_style/styles/styles.dart';
import 'my_theme_style_platform_interface.dart';

class MyThemeStyle {
  static late LocaleLogic _localeLogic;
  static late String _localeName;
  static late AppStyle _appStyle;

  static Future<void> initialize({
    required LocaleLogic localeLogic,
    required String localeName,
    Size? screenSize,
    bool disableAnimations = false,
    bool highContrast = false,
    Map<String, dynamic> colorsMap = const {},
    Map<String, dynamic> cornersMap = const {},
    Map<String, dynamic> shadowsMap = const {},
    Map<String, dynamic> insetsMap = const {},
    Map<String, dynamic> textsMap = const {},
    Map<String, dynamic> timesMap = const {},
    Map<String, dynamic> sizesMap = const {},
  }) async {
    _localeLogic = localeLogic;
    _localeName = localeName;
    _appStyle = AppStyle(
      disableAnimations: disableAnimations,
      highContrast: highContrast,
      screenSize: screenSize,
      colorsMap: colorsMap,
      cornersMap: cornersMap,
      shadowsMap: shadowsMap,
      insetsMap: insetsMap,
      textsMap: textsMap,
      timesMap: timesMap,
      sizesMap: sizesMap,
    );
  }

  static LocaleLogic get localeLogic => _localeLogic;

  static String get localeName => _localeName;

  static AppStyle get appStyle => _appStyle;

  Future<String?> getPlatformVersion() {
    return MyThemeStylePlatform.instance.getPlatformVersion();
  }
}
