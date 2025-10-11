import 'package:flutter/material.dart';
import 'package:my_theme_style/my_theme_style.dart';

@immutable
class Texts {
  final double _scale;
  final Map<String, Map<String, dynamic>> _fontConfigs;
  final Map<String, Map<String, dynamic>> _styleGroups;
  final bool useEmphasized;

  Texts._(
    this._scale,
    this._fontConfigs,
    this._styleGroups, {
    this.useEmphasized = false,
  });

  late final _TextStyleHandler _styleHandler = _TextStyleHandler(
    scale: _scale,
    styleGroups: _styleGroups,
    useEmphasized: useEmphasized,
  );

  late final _FontHandler _fontHandler = _FontHandler(
    useEmphasized: useEmphasized,
  );

  factory Texts.fromJson(
    Map<String, dynamic> textStylesMap,
    Map<String, dynamic> fontsMap, {
    double scale = 1.0,
    bool useEmphasized = false,
  }) {
    final fontConfigs = <String, Map<String, dynamic>>{};
    if (fontsMap['fonts'] is List) {
      for (var fontData in (fontsMap['fonts'] as List)) {
        if (fontData is Map<String, dynamic> &&
            fontData.containsKey('family')) {
          final family = fontData['family'] as String;
          fontConfigs[family] = {
            'family': family,
            'locale': fontData['locale'],
            'fontFeatures': fontData['fontFeatures'],
            'fonts':
                (fontData['fonts'] as List<dynamic>?)
                    ?.map((e) => Map<String, dynamic>.from(e))
                    .toList() ??
                [],
          };
        }
      }
    }

    // Retained for backward compatibility if needed, but new logic uses fontConfigs
    final fonts = fontConfigs;
    // Parse styles: each key is a group (e.g. "md.sys.typescale")
    final styles = <String, Map<String, dynamic>>{};
    (textStylesMap['styles'] as Map<String, dynamic>?)?.forEach((
      group,
      groupStyles,
    ) {
      styles[group] = Map<String, dynamic>.from(groupStyles);
    });

    return Texts._(scale, fonts, styles, useEmphasized: useEmphasized);
  }

  // Font getters for custom fonts
  TextStyle get btn => bodyMedium;

  TextStyle get titleFont =>
      _fontHandler.getFont(_fontConfigs['Raleway'] ?? {});

  TextStyle get monoTitleFont =>
      _fontHandler.getFont(_fontConfigs['B612Mono'] ?? {});

  TextStyle get chinaFont =>
      _fontHandler.getFont(_fontConfigs['MaShanZheng'] ?? {});

  /// Returns a Flutter [TextTheme] using Material 3 tokens
  /// If [emphasized] is true (or [useEmphasized] is set), uses emphasized variants
  TextTheme textTheme({bool? emphasized}) {
    final useEm = emphasized ?? useEmphasized;
    return TextTheme(
      displayLarge: _styleHandler.token('display-large', emphasized: useEm),
      displayMedium: _styleHandler.token('display-medium', emphasized: useEm),
      displaySmall: _styleHandler.token('display-small', emphasized: useEm),
      headlineLarge: _styleHandler.token('headline-large', emphasized: useEm),
      headlineMedium: _styleHandler.token('headline-medium', emphasized: useEm),
      headlineSmall: _styleHandler.token('headline-small', emphasized: useEm),
      titleLarge: _styleHandler.token('title-large', emphasized: useEm),
      titleMedium: _styleHandler.token('title-medium', emphasized: useEm),
      titleSmall: _styleHandler.token('title-small', emphasized: useEm),
      bodyLarge: _styleHandler.token('body-large', emphasized: useEm),
      bodyMedium: _styleHandler.token('body-medium', emphasized: useEm),
      bodySmall: _styleHandler.token('body-small', emphasized: useEm),
      labelLarge: _styleHandler.token('label-large', emphasized: useEm),
      labelMedium: _styleHandler.token('label-medium', emphasized: useEm),
      labelSmall: _styleHandler.token('label-small', emphasized: useEm),
    );
  }

  // Shorthand for common Material 3 styles (normal)
  TextStyle get displayLarge => _styleHandler.token('display-large');

  TextStyle get displayMedium => _styleHandler.token('display-medium');

  TextStyle get displaySmall => _styleHandler.token('display-small');

  TextStyle get headlineLarge => _styleHandler.token('headline-large');

  TextStyle get headlineMedium => _styleHandler.token('headline-medium');

  TextStyle get headlineSmall => _styleHandler.token('headline-small');

  TextStyle get titleLarge => _styleHandler.token('title-large');

  TextStyle get titleMedium => _styleHandler.token('title-medium');

  TextStyle get titleSmall => _styleHandler.token('title-small');

  TextStyle get labelLarge => _styleHandler.token('label-large');

  TextStyle get labelMedium => _styleHandler.token('label-medium');

  TextStyle get labelSmall => _styleHandler.token('label-small');

  TextStyle get bodyLarge => _styleHandler.token('body-large');

  TextStyle get bodyMedium => _styleHandler.token('body-medium');

  TextStyle get bodySmall => _styleHandler.token('body-small');

  // Emphasized variants, always use emphasized group
  TextStyle get displayLargeEmphasized =>
      _styleHandler.token('display-large', emphasized: true);

  TextStyle get displayMediumEmphasized =>
      _styleHandler.token('display-medium', emphasized: true);

  TextStyle get displaySmallEmphasized =>
      _styleHandler.token('display-small', emphasized: true);

  TextStyle get headlineLargeEmphasized =>
      _styleHandler.token('headline-large', emphasized: true);

  TextStyle get headlineMediumEmphasized =>
      _styleHandler.token('headline-medium', emphasized: true);

  TextStyle get headlineSmallEmphasized =>
      _styleHandler.token('headline-small', emphasized: true);

  TextStyle get titleLargeEmphasized =>
      _styleHandler.token('title-large', emphasized: true);

  TextStyle get titleMediumEmphasized =>
      _styleHandler.token('title-medium', emphasized: true);

  TextStyle get titleSmallEmphasized =>
      _styleHandler.token('title-small', emphasized: true);

  TextStyle get labelLargeEmphasized =>
      _styleHandler.token('label-large', emphasized: true);

  TextStyle get labelMediumEmphasized =>
      _styleHandler.token('label-medium', emphasized: true);

  TextStyle get labelSmallEmphasized =>
      _styleHandler.token('label-small', emphasized: true);

  TextStyle get bodyLargeEmphasized =>
      _styleHandler.token('body-large', emphasized: true);

  TextStyle get bodyMediumEmphasized =>
      _styleHandler.token('body-medium', emphasized: true);

  TextStyle get bodySmallEmphasized =>
      _styleHandler.token('body-small', emphasized: true);
}

@immutable
class _TextStyleHandler {
  final Map<String, Map<String, dynamic>> _styleGroups;
  final double _scale;
  final bool useEmphasized;

  const _TextStyleHandler({
    required double scale,
    required Map<String, Map<String, dynamic>> styleGroups,
    required this.useEmphasized,
  }) : _styleGroups = styleGroups,
       _scale = scale;

  TextStyle _createFontFromToken(Map<String, dynamic> config) {
    double sizePx = (config['fontSize'] as num).toDouble() * _scale;
    double? heightPx = (config['lineHeight'] as num?)?.toDouble();
    double? spacingPc = (config['letterSpacing'] as num?)?.toDouble();

    FontWeight? weight;
    final fwStr = config['fontWeight']?.toString();
    if (fwStr != null) {
      switch (fwStr) {
        case 'w100':
          weight = FontWeight.w400;
        case 'w200':
          weight = FontWeight.w500;
        case 'w300':
          weight = FontWeight.w600;
        case 'w400':
          weight = FontWeight.w400;
        case 'w500':
          weight = FontWeight.w500;
        case 'w600':
          weight = FontWeight.w600;
        case 'w700':
          weight = FontWeight.w700;
        case 'w800':
          weight = FontWeight.w800;
        case 'w900':
          weight = FontWeight.w900;
        case 'normal':
          weight = FontWeight.normal;
        case 'bold':
          weight = FontWeight.bold;
        default:
          weight = FontWeight.normal;
      }
    }

    return TextStyle(
      fontFamily: config['fontFamily'],
      fontWeight: weight,
      fontSize: sizePx,
      height: heightPx != null ? (heightPx / sizePx) : null,
      letterSpacing: spacingPc,
    );
  }

  /// Universal _styleHandler.token getter, choose emphasized group based on configuration or parameter
  TextStyle token(String name, {bool? emphasized}) {
    final useEm = emphasized ?? useEmphasized;
    final group = useEm ? 'md.sys.typescale.emphasized' : 'md.sys.typescale';
    final groupMap = _styleGroups[group];
    if (groupMap == null) {
      throw Exception('Style group $group not found');
    }
    final styleConfig = groupMap[name];
    if (styleConfig == null) {
      throw Exception('Style $name not found in group $group');
    }
    return _createFontFromToken(styleConfig);
  }
}

@immutable
class _FontHandler {
  final bool useEmphasized;

  const _FontHandler({required this.useEmphasized});

  TextStyle getFont(Map<String, dynamic> fonts) {
    String locale = MyThemeStyle.localeLogic.isLoaded
        ? MyThemeStyle.localeName
        : fonts.keys.first;
    final fontConfig = fonts[locale] ?? fonts.values.first;
    return _textStyleFromConfig(fontConfig);
  }

  TextStyle _textStyleFromConfig(Map<String, dynamic> config) {
    return TextStyle(
      fontFamily: config['fontFamily'],
      fontFeatures: (config['fontFeatures'] is List)
          ? (config['fontFeatures'] as List)
                .map((f) => FontFeature.enable(f.toString()))
                .toList()
          : null,
    );
  }
}
