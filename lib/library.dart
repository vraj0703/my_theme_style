library;

import 'package:my_theme_style/my_theme_style.dart';

export 'package:my_theme_style/styles/colors.dart';
export 'package:my_theme_style/styles/styles.dart';

get $style => MyThemeStyle.appStyle;

get $colors => MyThemeStyle.appStyle.colors;

get $corners => MyThemeStyle.appStyle.corners;

get $shadows => MyThemeStyle.appStyle.shadows;

get $insets => MyThemeStyle.appStyle.insets;

get $textStyle => MyThemeStyle.appStyle.text;

get $durations => MyThemeStyle.appStyle.times;

get $sizes => MyThemeStyle.appStyle.sizes;

get $icons => MyThemeStyle.appStyle.icons;
