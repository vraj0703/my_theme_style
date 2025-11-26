import 'package:flutter/material.dart';
import 'package:my_theme_style/my_theme_style.dart';

@immutable
class Texts {
  final double _scale;
  // Map<Family, Map<Locale, Config>>
  final Map<String, Map<String, Map<String, dynamic>>> _fontConfigs;
  final Map<String, Map<String, dynamic>> _styleGroups;

  Texts._(this._scale, this._fontConfigs, this._styleGroups);

  late final _TextStyleHandler _styleHandler = _TextStyleHandler(
    scale: _scale,
    styleGroups: _styleGroups,
    fontConfigs: _fontConfigs,
    fontHandler: _fontHandler,
  );

  late final _FontHandler _fontHandler = const _FontHandler();

  factory Texts.fromJson(
    Map<String, dynamic> textStylesMap,
    Map<String, dynamic> fontsMap, {
    double scale = 1.0,
  }) {
    final fontConfigs = <String, Map<String, Map<String, dynamic>>>{};
    if (fontsMap['fonts'] is List) {
      for (var fontData in (fontsMap['fonts'] as List)) {
        if (fontData is Map<String, dynamic> &&
            fontData.containsKey('family')) {
          final family = fontData['family'] as String;
          final locale = fontData['locale'] as String? ?? 'default';

          if (!fontConfigs.containsKey(family)) {
            fontConfigs[family] = {};
          }

          fontConfigs[family]![locale] = {
            'family': family,
            'locale': locale,
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

    // Parse styles: each key is a group (e.g. "md.sys.typescale")
    final styles = <String, Map<String, dynamic>>{};
    (textStylesMap['styles'] as Map<String, dynamic>?)?.forEach((
      group,
      groupStyles,
    ) {
      styles[group] = Map<String, dynamic>.from(groupStyles);
    });

    return Texts._(scale, fontConfigs, styles);
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
  TextTheme textTheme() {
    return TextTheme(
      displayLarge: _styleHandler.token('display-large'),
      displayMedium: _styleHandler.token('display-medium'),
      displaySmall: _styleHandler.token('display-small'),
      headlineLarge: _styleHandler.token('headline-large'),
      headlineMedium: _styleHandler.token('headline-medium'),
      headlineSmall: _styleHandler.token('headline-small'),
      titleLarge: _styleHandler.token('title-large'),
      titleMedium: _styleHandler.token('title-medium'),
      titleSmall: _styleHandler.token('title-small'),
      bodyLarge: _styleHandler.token('body-large'),
      bodyMedium: _styleHandler.token('body-medium'),
      bodySmall: _styleHandler.token('body-small'),
      labelLarge: _styleHandler.token('label-large'),
      labelMedium: _styleHandler.token('label-medium'),
      labelSmall: _styleHandler.token('label-small'),
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
}

@immutable
class _TextStyleHandler {
  final Map<String, Map<String, dynamic>> _styleGroups;
  final Map<String, Map<String, Map<String, dynamic>>> _fontConfigs;
  final _FontHandler _fontHandler;
  final double _scale;

  const _TextStyleHandler({
    required double scale,
    required Map<String, Map<String, dynamic>> styleGroups,
    required Map<String, Map<String, Map<String, dynamic>>> fontConfigs,
    required _FontHandler fontHandler,
  }) : _styleGroups = styleGroups,
       _fontConfigs = fontConfigs,
       _fontHandler = fontHandler,
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

    final family = config['fontFamily'] as String?;
    TextStyle fontStyle = const TextStyle();

    if (family != null && _fontConfigs.containsKey(family)) {
      fontStyle = _fontHandler.getFont(_fontConfigs[family]!);
    } else {
      fontStyle = TextStyle(fontFamily: family);
    }

    return fontStyle.copyWith(
      fontWeight: weight,
      fontSize: sizePx,
      height: heightPx != null ? (heightPx / sizePx) : null,
      letterSpacing: spacingPc,
    );
  }

  /// Universal _styleHandler.token getter
  TextStyle token(String name) {
    final group = 'md.sys.typescale';
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
  const _FontHandler();

  // fonts is Map<Locale, Config>
  TextStyle getFont(Map<String, Map<String, dynamic>> fonts) {
    if (fonts.isEmpty) return const TextStyle();

    String locale =
        (MyThemeStyle.isInitialized &&
            MyThemeStyle.hasLocaleLogic &&
            MyThemeStyle.localeLogic.isLoaded)
        ? MyThemeStyle.localeName
        : 'default';

    // Try specific locale, then 'en', then 'default', then first available
    final fontConfig =
        fonts[locale] ?? fonts['en'] ?? fonts['default'] ?? fonts.values.first;

    return _textStyleFromConfig(fontConfig);
  }

  TextStyle _textStyleFromConfig(Map<String, dynamic> config) {
    return TextStyle(
      fontFamily:
          config['family'], // Use 'family' from config, not 'fontFamily' which might be missing in fonts.json
      fontFeatures: (config['fontFeatures'] is List)
          ? (config['fontFeatures'] as List)
                .map((f) => FontFeature.enable(f.toString()))
                .toList()
          : null,
    );
  }
}
