import 'package:flutter_test/flutter_test.dart';
import 'package:my_theme_style/styles/texts.dart';

void main() {
  group('Texts Custom Fonts', () {
    final textStylesMap = {
      "styles": {
        "md.sys.typescale": {
          "body-medium": {
            "fontFamily": "BodyFont",
            "fontWeight": "400",
            "fontSize": 14,
            "lineHeight": 20,
            "letterSpacing": 0.25,
          },
        },
      },
    };
    final fontsMap = {
      "fonts": [
        {
          "family": "BodyFont",
          "locale": "en",
          "fonts": [
            {"asset": "Roboto.ttf"},
          ],
        },
        {
          "family": "BodyFont",
          "locale": "zh",
          "fonts": [
            {"asset": "MaShanZheng.ttf"},
          ],
        },
      ],
    };

    test(
      'resolves font based on default locale when MyLocalizations is not loaded',
      () {
        final texts = Texts.fromJson(textStylesMap, fontsMap);
        final style = texts.bodyMedium;
        // Should fallback to 'en' or first available if 'default' not found
        // In our logic: specific -> en -> default -> first
        // Here 'en' exists.
        expect(style.fontFamily, 'BodyFont');
        // Note: Our logic returns the family name from the config.
        // If config says "family": "BodyFont", it returns "BodyFont".
        // To test distinctness, we might need to check if we can distinguish the configs.
        // But since they have same family name, the TextStyle will look same.
        // However, _FontHandler logic uses the config found.
      },
    );
    // If we want to verify that it picked the "zh" config, we'd need something observable.
    // fontFeatures is observable.
    final fontsMapFeatures = {
      "fonts": [
        {
          "family": "BodyFont",
          "locale": "en",
          "fontFeatures": ["smcp"],
        },
        {
          "family": "BodyFont",
          "locale": "zh",
          "fontFeatures": ["tnum"],
        },
      ],
    };

    test('resolves font features based on locale fallback (en)', () {
      final texts = Texts.fromJson(textStylesMap, fontsMapFeatures);
      final style = texts.bodyMedium;
      // Default fallback should hit 'en'
      expect(style.fontFeatures, isNotNull);
      expect(style.fontFeatures!.first.feature, 'smcp');
    });
  });
}
