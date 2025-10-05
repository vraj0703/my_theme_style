import 'package:flutter/material.dart';
import 'package:my_theme_style/my_theme_style.dart';

@immutable
class Texts {
  final double _scale;
  final Map<String, Map<String, dynamic>> _fontConfigs;
  final Map<String, Map<String, dynamic>> _styleGroups;
  final bool useEmphasized;

  const Texts._(
    this._scale,
    this._fontConfigs,
    this._styleGroups, {
    this.useEmphasized = false,
  });

  factory Texts.fromJson(
    Map<String, dynamic> json, {
    double scale = 1.0,
    bool useEmphasized = false,
  }) {
    // Parse fonts as before
    final fonts = Map<String, Map<String, dynamic>>.from(
      json['fonts']?.map((k, v) => MapEntry(k, Map<String, dynamic>.from(v))) ??
          {},
    );

    // Parse styles: each key is a group (e.g. "md.sys.typescale")
    final styles = <String, Map<String, dynamic>>{};
    (json['styles'] as Map<String, dynamic>?)?.forEach((group, groupStyles) {
      styles[group] = Map<String, dynamic>.from(groupStyles);
    });

    return Texts._(scale, fonts, styles, useEmphasized: useEmphasized);
  }

  // Font getters for custom fonts
  TextStyle get titleFont =>
      _getFontForLocale(_fontConfigs['titleFonts'] ?? {});

  TextStyle get monoTitleFont =>
      _getFontForLocale(_fontConfigs['monoTitleFonts'] ?? {});

  TextStyle get quoteFont =>
      _getFontForLocale(_fontConfigs['quoteFonts'] ?? {});

  TextStyle get contentFont =>
      _getFontForLocale(_fontConfigs['contentFonts'] ?? {});

  /// Universal token getter, choose emphasized group based on configuration or parameter
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

  /// Returns a Flutter [TextTheme] using Material 3 tokens
  /// If [emphasized] is true (or [useEmphasized] is set), uses emphasized variants
  TextTheme textTheme({bool? emphasized}) {
    final useEm = emphasized ?? useEmphasized;
    return TextTheme(
      displayLarge: token('display-large', emphasized: useEm),
      displayMedium: token('display-medium', emphasized: useEm),
      displaySmall: token('display-small', emphasized: useEm),
      headlineLarge: token('headline-large', emphasized: useEm),
      headlineMedium: token('headline-medium', emphasized: useEm),
      headlineSmall: token('headline-small', emphasized: useEm),
      titleLarge: token('title-large', emphasized: useEm),
      titleMedium: token('title-medium', emphasized: useEm),
      titleSmall: token('title-small', emphasized: useEm),
      bodyLarge: token('body-large', emphasized: useEm),
      bodyMedium: token('body-medium', emphasized: useEm),
      bodySmall: token('body-small', emphasized: useEm),
      labelLarge: token('label-large', emphasized: useEm),
      labelMedium: token('label-medium', emphasized: useEm),
      labelSmall: token('label-small', emphasized: useEm),
    );
  }

  TextStyle _getFontForLocale(Map<String, dynamic> fonts) {
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

  // Shorthand for common Material 3 styles (normal)
  TextStyle get displayLarge => token('display-large');

  TextStyle get displayMedium => token('display-medium');

  TextStyle get displaySmall => token('display-small');

  TextStyle get headlineLarge => token('headline-large');

  TextStyle get headlineMedium => token('headline-medium');

  TextStyle get headlineSmall => token('headline-small');

  TextStyle get titleLarge => token('title-large');

  TextStyle get titleMedium => token('title-medium');

  TextStyle get titleSmall => token('title-small');

  TextStyle get labelLarge => token('label-large');

  TextStyle get labelMedium => token('label-medium');

  TextStyle get labelSmall => token('label-small');

  TextStyle get bodyLarge => token('body-large');

  TextStyle get bodyMedium => token('body-medium');

  TextStyle get bodySmall => token('body-small');

  // Emphasized variants, always use emphasized group
  TextStyle get displayLargeEmphasized =>
      token('display-large', emphasized: true);

  TextStyle get displayMediumEmphasized =>
      token('display-medium', emphasized: true);

  TextStyle get displaySmallEmphasized =>
      token('display-small', emphasized: true);

  TextStyle get headlineLargeEmphasized =>
      token('headline-large', emphasized: true);

  TextStyle get headlineMediumEmphasized =>
      token('headline-medium', emphasized: true);

  TextStyle get headlineSmallEmphasized =>
      token('headline-small', emphasized: true);

  TextStyle get titleLargeEmphasized => token('title-large', emphasized: true);

  TextStyle get titleMediumEmphasized =>
      token('title-medium', emphasized: true);

  TextStyle get titleSmallEmphasized => token('title-small', emphasized: true);

  TextStyle get labelLargeEmphasized => token('label-large', emphasized: true);

  TextStyle get labelMediumEmphasized =>
      token('label-medium', emphasized: true);

  TextStyle get labelSmallEmphasized => token('label-small', emphasized: true);

  TextStyle get bodyLargeEmphasized => token('body-large', emphasized: true);

  TextStyle get bodyMediumEmphasized => token('body-medium', emphasized: true);

  TextStyle get bodySmallEmphasized => token('body-small', emphasized: true);
}
