import 'dart:ui';
import 'package:my_localizations/library.dart';
import 'package:my_theme_style/styles/styles.dart';
import 'my_theme_style_platform_interface.dart';

class MyThemeStyle {
  static late MyLocalizations _localeLogic;
  static late AppStyle _appStyle;

  static Future<void> initialize({
    required MyLocalizations localeLogic,
    Size? screenSize,
    bool disableAnimations = false,
    bool highContrast = false,
    Map<String, dynamic> colorsMap = const {},
    Map<String, dynamic> colorSchemesMap = const {},
    Map<String, dynamic> cornersMap = const {},
    Map<String, dynamic> shadowsMap = const {},
    Map<String, dynamic> insetsMap = const {},
    Map<String, dynamic> textStylesMap = const {},
    Map<String, dynamic> fontsMap = const {},
    Map<String, dynamic> timesMap = const {},
    Map<String, dynamic> sizesMap = const {},
  }) async {
    _localeLogic = localeLogic;
    _appStyle = AppStyle(
      disableAnimations: disableAnimations,
      highContrast: highContrast,
      screenSize: screenSize,
      colorsMap: colorsMap,
      colorSchemesMap: colorSchemesMap,
      cornersMap: cornersMap,
      shadowsMap: shadowsMap,
      insetsMap: insetsMap,
      textStylesMap: textStylesMap,
      timesMap: timesMap,
      sizesMap: sizesMap,
      fontsMap: fontsMap,
    );
  }

  static MyLocalizations get localeLogic => _localeLogic;

  static String get localeName => _localeLogic.strings.localeName;

  static AppStyle get appStyle => _appStyle;

  Future<String?> getPlatformVersion() {
    return MyThemeStylePlatform.instance.getPlatformVersion();
  }
}
