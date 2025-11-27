import 'package:flutter/material.dart';
import 'package:my_theme_style/library.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.size = 22, this.color});

  final IconData icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    //String i = icon.name.toLowerCase().replaceAll('_', '-');
    //String path = 'assets/images/_common/icons/icon-$i.png';
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Icon(icon, size: size, color: color ?? $colors.offWhite),
      ),
    );
  }
}
