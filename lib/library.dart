library;

import 'package:my_theme_style/my_theme_style.dart';
import 'package:my_theme_style/styles/app_icons.dart';
import 'package:my_theme_style/styles/corners.dart';
import 'package:my_theme_style/styles/insets.dart';
import 'package:my_theme_style/styles/shadows.dart';
import 'package:my_theme_style/styles/sizes.dart';
import 'package:my_theme_style/styles/styles.dart';
import 'package:my_theme_style/styles/texts.dart';
import 'package:my_theme_style/styles/times.dart';
export 'package:my_theme_style/styles/colors.dart';
export 'package:my_theme_style/styles/styles.dart';

AppStyle get $style => MyThemeStyle.appStyle;

AppColors get $colors => MyThemeStyle.appStyle.colors;

AppGradients get $gradients => MyThemeStyle.appStyle.gradients;

Corners get $corners => MyThemeStyle.appStyle.corners;

Shadows get $shadows => MyThemeStyle.appStyle.shadows;

Insets get $insets => MyThemeStyle.appStyle.insets;

Texts get $textStyle => MyThemeStyle.appStyle.text;

Times get $durations => MyThemeStyle.appStyle.times;

Sizes get $sizes => MyThemeStyle.appStyle.sizes;

typedef $icons = AppIcons;
