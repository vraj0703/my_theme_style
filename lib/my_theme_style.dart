
import 'my_theme_style_platform_interface.dart';

class MyThemeStyle {
  Future<String?> getPlatformVersion() {
    return MyThemeStylePlatform.instance.getPlatformVersion();
  }
}
