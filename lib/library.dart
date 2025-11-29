library;

import 'package:my_theme_style/my_theme_style.dart';
import 'package:my_theme_style/styles/app_icons.dart';
export 'package:my_theme_style/styles/colors.dart';
export 'package:my_theme_style/styles/styles.dart';

get $style => MyThemeStyle.appStyle;

get $colors => MyThemeStyle.appStyle.colors;

get $gradients => MyThemeStyle.appStyle.gradients;

get $corners => MyThemeStyle.appStyle.corners;

get $shadows => MyThemeStyle.appStyle.shadows;

get $insets => MyThemeStyle.appStyle.insets;

get $textStyle => MyThemeStyle.appStyle.text;

get $durations => MyThemeStyle.appStyle.times;

get $sizes => MyThemeStyle.appStyle.sizes;

typedef $icons = AppIcons;
