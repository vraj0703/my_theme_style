import 'package:flutter/material.dart';
import 'package:my_theme_style/library.dart';

import 'icons.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.size = 22, this.color});

  final AppIcons icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // eg icon name in _common/icons folder is 'icon-close-large.png', 'icon-close.png'
    String i = icon.name.toLowerCase().replaceAll('_', '-');
    String path = 'assets/images/_common/icons/icon-$i.png';
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Image.asset(
          path,
          width: size,
          height: size,
          color: color ?? $colors.offWhite,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
