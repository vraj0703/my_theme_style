import 'dart:ui';
import 'package:my_theme_style/styles/styles.dart';
import 'my_theme_style_platform_interface.dart';

class MyThemeStyle {
  static String? _localeName;
  static AppStyle? _appStyle;
  static String _currentTheme = 'light';

  /// Get the current active theme mode ('light' or 'dark')
  static String get currentTheme => _currentTheme;

  /// Update the current theme mode
  static void setTheme(String theme) {
    _currentTheme = theme;
  }

  static Future<void> initialize({
    String? localeName,
    Size? screenSize,
    bool disableAnimations = false,
    bool highContrast = false,
    Map<String, dynamic> colorsMap = const {},
    Map<String, dynamic> gradientsMap = const {},
    Map<String, dynamic> cornersMap = const {},
    Map<String, dynamic> shadowsMap = const {},
    Map<String, dynamic> insetsMap = const {},
    Map<String, dynamic> textStylesMap = const {},
    Map<String, dynamic> fontsMap = const {},
    Map<String, dynamic> timesMap = const {},
    Map<String, dynamic> sizesMap = const {},
    Map<String, dynamic> iconsMap = const {},
  }) async {
    _localeName = localeName;
    _appStyle = AppStyle(
      disableAnimations: disableAnimations,
      highContrast: highContrast,
      screenSize: screenSize,
      colorsMap: colorsMap,
      gradientsMap: gradientsMap,
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

  static String get localeName {
    if (_localeName == null) {
      throw Exception('LocaleName not initialized.');
    }
    return _localeName!;
  }

  static bool get isInitialized => _appStyle != null;

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
