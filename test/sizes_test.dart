import 'package:flutter_test/flutter_test.dart';
import 'package:my_theme_style/styles/sizes.dart';

void main() {
  group('Sizes', () {
    test('parses default values correctly', () {
      final sizes = Sizes.fromJson({});

      expect(sizes.iconSm, 18.0);
      expect(sizes.iconMd, 24.0);
      expect(sizes.iconLg, 32.0);
      expect(sizes.iconXl, 48.0);

      expect(sizes.borderSm, 1.0);
      expect(sizes.borderMd, 2.0);
      expect(sizes.borderLg, 4.0);

      expect(sizes.maxContentWidth1, 800.0);
      expect(sizes.maxContentWidth2, 600.0);
      expect(sizes.maxContentWidth3, 500.0);

      expect(sizes.minAppWidth, 380.0);
      expect(sizes.minAppHeight, 650.0);
    });

    test('parses custom values correctly', () {
      final json = {
        'icon': {'sm': 20.0},
        'maxContent': {'width1': 900.0},
        'minAppSize': {'height': 700.0},
      };
      final sizes = Sizes.fromJson(json);

      expect(sizes.iconSm, 20.0);
      expect(sizes.maxContentWidth1, 900.0);
      expect(sizes.minAppHeight, 700.0);

      // Should still have other defaults
      expect(sizes.iconMd, 24.0);
      expect(sizes.maxContentWidth2, 600.0);
      expect(sizes.minAppWidth, 380.0);
    });
  });
}
