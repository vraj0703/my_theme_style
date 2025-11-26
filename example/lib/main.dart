import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:my_theme_style/library.dart';
import 'package:my_theme_style/my_theme_style.dart';

void main() {
  print('MAIN STARTED');
  runApp(const AppBootstrapper());
}

class AppBootstrapper extends StatefulWidget {
  const AppBootstrapper({super.key});

  @override
  State<AppBootstrapper> createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends State<AppBootstrapper> {
  bool _isInitialized = false;
  String _currentLocale = 'en';
  String _themeMode = 'light';

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    try {
      print('Initializing app...');
      // Load JSON configs from the package
      print('Loading assets...');
      final colorsMap = await _loadJson(
        'packages/my_theme_style/assets/jsons/app_colors.json',
      );
      final textsMap = await _loadJson(
        'packages/my_theme_style/assets/jsons/texts.json',
      );
      final shadowsMap = await _loadJson(
        'packages/my_theme_style/assets/jsons/shadows.json',
      );
      final cornersMap = await _loadJson(
        'packages/my_theme_style/assets/jsons/corners.json',
      );
      final durationMap = await _loadJson(
        'packages/my_theme_style/assets/jsons/duration.json',
      );
      final insetsMap = await _loadJson(
        'packages/my_theme_style/assets/jsons/insets.json',
      );
      final sizesMap = await _loadJson(
        'packages/my_theme_style/assets/jsons/sizes.json',
      );
      final iconsMap = await _loadJson(
        'packages/my_theme_style/assets/jsons/icons.json',
      );
      print('Assets loaded.');

      print('Initializing MyThemeStyle...');
      await MyThemeStyle.initialize(
        localeName: _currentLocale,
        colorsMap: colorsMap,
        textStylesMap: textsMap,
        shadowsMap: shadowsMap,
        cornersMap: cornersMap,
        timesMap: durationMap,
        insetsMap: insetsMap,
        sizesMap: sizesMap,
        fontsMap: {}, // Pass empty map if fonts.json is not loaded
        iconsMap: iconsMap,
      );
      print('MyThemeStyle initialized.');

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e, stack) {
      print('Error initializing app: $e');
      print(stack.toString());
    }
  }

  Future<void> _updateLocale(String locale) async {
    setState(() {
      _isInitialized = false; // Show loading
      _currentLocale = locale;
    });
    await _initApp();
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == 'light' ? 'dark' : 'light';
      MyThemeStyle.setTheme(_themeMode);
    });
  }

  Future<Map<String, dynamic>> _loadJson(String path) async {
    try {
      final String response = await rootBundle.loadString(path);
      return json.decode(response);
    } catch (e) {
      print('Error loading $path: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    final themeData = $style.themeData(theme: _themeMode);

    return MaterialApp(
      title: 'MyThemeStyle Example',
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MyThemeStyle Example'),
          actions: [
            IconButton(
              icon: Icon(
                _currentLocale == 'en' ? Icons.language : Icons.translate,
              ),
              onPressed: () =>
                  _updateLocale(_currentLocale == 'en' ? 'zh' : 'en'),
              tooltip: 'Switch Locale (Current: $_currentLocale)',
            ),
            IconButton(
              icon: Icon(
                _themeMode == 'light' ? Icons.dark_mode : Icons.light_mode,
              ),
              onPressed: _toggleTheme,
              tooltip: 'Toggle Theme',
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all($insets.md),
          children: [
            _SectionHeader(title: 'Typography ($_currentLocale)'),
            _TypographyShowcase(),
            const SizedBox(height: 24),
            const _SectionHeader(title: 'Colors'),
            _ColorsShowcase(themeMode: _themeMode),
            const SizedBox(height: 24),
            const _SectionHeader(title: 'Icons'),
            const _IconsShowcase(),
            const SizedBox(height: 24),
            const _SectionHeader(title: 'Shapes & Shadows'),
            const _ShapesShadowsShowcase(),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: $textStyle.headlineSmall),
        Divider(color: $colors.outlineVariantLight),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _TypographyShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Display Large', style: $textStyle.displayLarge),
        Text('Headline Medium', style: $textStyle.headlineMedium),
        Text('Body Large', style: $textStyle.bodyLarge),
        Text('Label Small', style: $textStyle.labelSmall),
        const SizedBox(height: 8),
        Text('Custom Font (Title):', style: $textStyle.titleMedium),
        Text(
          'Raleway Font',
          style: $textStyle.titleFont.copyWith(fontSize: 20),
        ),
      ],
    );
  }
}

class _ColorsShowcase extends StatelessWidget {
  final String themeMode;
  const _ColorsShowcase({required this.themeMode});

  @override
  Widget build(BuildContext context) {
    // Helper to get color based on current theme mode for display
    Color c(String key) => $style.colors.color(themeMode, key);

    return Wrap(
      spacing: $insets.sm,
      runSpacing: $insets.sm,
      children: [
        _ColorBox(name: 'Primary', color: c('primary')),
        _ColorBox(name: 'Secondary', color: c('secondary')),
        _ColorBox(name: 'Tertiary', color: c('tertiary')),
        _ColorBox(name: 'Error', color: c('error')),
        _ColorBox(name: 'Surface', color: c('surface')),
        _ColorBox(name: 'Background', color: c('background')),
        _ColorBox(
          name: 'Brand',
          color: $style.colors.custom('brandColor').color('orange'),
        ),
      ],
    );
  }
}

class _IconsShowcase extends StatelessWidget {
  const _IconsShowcase();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(
              $icons.home,
              size: $sizes.iconLg,
              color: $style.colors.primaryLight,
            ),
            Text('Home', style: $textStyle.labelSmall),
          ],
        ),
        Column(
          children: [
            Icon(
              $icons.settings,
              size: $sizes.iconLg,
              color: $style.colors.secondaryLight,
            ),
            Text('Settings', style: $textStyle.labelSmall),
          ],
        ),
        Column(
          children: [
            Icon(
              $icons.favorite,
              size: $sizes.iconLg,
              color: $style.colors.errorLight,
            ),
            Text('Favorite', style: $textStyle.labelSmall),
          ],
        ),
      ],
    );
  }
}

class _ShapesShadowsShowcase extends StatelessWidget {
  const _ShapesShadowsShowcase();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: $style.colors.surfaceVariantLight,
            borderRadius: BorderRadius.circular($corners.medium),
            boxShadow: $shadows.level2,
          ),
          alignment: Alignment.center,
          child: Text(
            'Md\nLvl2',
            style: $textStyle.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: $style.colors.surfaceVariantLight,
            borderRadius: BorderRadius.circular($corners.extraLarge),
            boxShadow: $shadows.level4,
          ),
          alignment: Alignment.center,
          child: Text(
            'XL\nLvl4',
            style: $textStyle.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _ColorBox extends StatelessWidget {
  final String name;
  final Color color;

  const _ColorBox({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular($corners.small),
            border: Border.all(color: $style.colors.outlineLight),
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: $textStyle.labelSmall),
      ],
    );
  }
}
