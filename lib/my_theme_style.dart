import 'dart:ui';
import 'package:my_localizations/library.dart';
import 'package:my_theme_style/styles/styles.dart';
import 'my_theme_style_platform_interface.dart';

class MyThemeStyle {
  static MyLocalizations? _localeLogic;
  static AppStyle? _appStyle;

  static Future<void> initialize({
    MyLocalizations? localeLogic,
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
    Map<String, dynamic> iconsMap = const {},
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
      iconsMap: iconsMap,
    );
  }

  static MyLocalizations get localeLogic {
    if (_localeLogic == null) {
      throw Exception('MyLocalizations not initialized.');
    }
    return _localeLogic!;
  }

  static bool get isInitialized => _appStyle != null;
  static bool get hasLocaleLogic => _localeLogic != null;

  static String get localeName => localeLogic.strings.localeName;

  static AppStyle get appStyle {
    if (_appStyle == null) {
      throw Exception('MyThemeStyle not initialized. Call initialize() first.');
    }
    return _appStyle!;
  }

  Future<String?> getPlatformVersion() {
    return MyThemeStylePlatform.instance.getPlatformVersion();
  }
}
