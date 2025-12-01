import 'package:flutter/material.dart';
import 'package:my_theme_style/library.dart';
import 'package:my_theme_style/styles/app_icons.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.size = 22, this.color});

  final AppIcons icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Icon(
          AppIcons.icon(icon),
          size: size,
          color: color ?? $colors.offWhite,
        ),
      ),
    );
  }
}
