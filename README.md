# my_theme_style

A Flutter plugin for JSON-configurable styling and theming. Manage your app's design system (colors, typography, icons, shapes, shadows, spacing) entirely through JSON files.

## Features

- **JSON Configuration**: Define your design system in `assets/jsons/`.
- **Material 3 Support**: Built-in support for Material 3 tokens and roles.
- **Dynamic Theming**: Switch between light and dark modes easily.
- **Type-Safe Access**: Access styles via generated Dart classes (`$style`, `$colors`, etc.).
- **Hot Reload Friendly**: Update JSONs and restart to see changes (hot reload support depends on implementation).

## Installation

Add `my_theme_style` to your `pubspec.yaml`:

```yaml
dependencies:
  my_theme_style:
    git:
      url: https://github.com/your_username/my_theme_style.git
```

## Setup

1.  **Create Assets**: Create a folder `assets/jsons/` in your project root and add your configuration files:
    -   `app_colors.json`
    -   `texts.json`
    -   `icons.json`
    -   `shadows.json`
    -   `corners.json`
    -   `duration.json`
    -   `insets.json`
    -   `sizes.json`
    -   `gradients.json`
    -   `fonts.json`

2.  **Update pubspec.yaml**:

    ```yaml
    flutter:
      assets:
        - assets/jsons/
    ```

3.  **Initialize**:

    In your `main.dart`:

    ```dart
    void main() async {
      WidgetsFlutterBinding.ensureInitialized();

      // Load your JSONs (implementation depends on how you load assets)
      final colorsMap = await loadJson('assets/jsons/app_colors.json');
      // ... load other JSONs

      await MyThemeStyle.initialize(
        localeLogic: yourLocaleLogic, // from my_localizations
        colorsMap: colorsMap,
        // ... pass other maps
      );

      runApp(const MyApp());
    }
    ```

## Usage

Access styles globally using the `$` getters:

```dart
// Colors
Container(color: $colors.primaryLight);

// Typography
Text('Hello', style: $textStyle.headlineMedium);

// Icons
Icon($icons.back);

// Spacing
Padding(padding: EdgeInsets.all($insets.md));

// Shapes
BorderRadius.circular($corners.medium);

// Shadows
BoxShadow(boxShadow: $shadows.level2);

// Gradients
Container(decoration: BoxDecoration(gradient: $gradients.primary));
```

## Configuration Guide

### Colors (`app_colors.json`)
Define `schemes` (light/dark) and `base` colors.
```json
{
  "schemes": {
    "light": { "primary": "#6750A4", ... },
    "dark": { "primary": "#D0BCFF", ... }
  },
  "base": { "white": "#FFFFFF", ... },
  "custom": {
    "brandColor": {
      "light": "#FF5722",
      "dark": "#FF8A65"
    }
  }
}
```

### Typography (`texts.json`)
Define Material 3 type scale.
```json
{
  "styles": {
    "md.sys.typescale": {
      "display-large": { "fontSize": 57, "fontWeight": "400", ... }
    }
  }
}
```

### Icons (`icons.json`)
Map logical names to Material icons.
```json
{
  "icons": {
    "back": "arrow_back",
    "home": "home"
  }
}
```



### Gradients (`gradients.json`)
Define linear, radial, or sweep gradients. Supports theme-aware definitions.
```json
{
  "primary": {
    "light": {
      "type": "linear",
      "colors": [
        {"color": "#6750A4", "stop": 0.0},
        {"color": "#EADDFF", "stop": 1.0}
      ],
      "begin": "topLeft",
      "end": "bottomRight"
    },
    "dark": { ... }
  },
  "rainbow": {
    "type": "linear",
    "colors": [
      {"color": "#FF0000", "stop": 0.0},
      {"color": "#0000FF", "stop": 1.0}
    ]
  }
}
```

### Custom Fonts (`fonts.json`)
Map logical font names to font families.
```json
{
  "fonts": {
    "titleFont": "Raleway",
    "bodyFont": "Roboto"
  }
}
```

See the `example/` directory for a full working application.
