import 'package:flutter_test/flutter_test.dart';
import 'package:my_theme_style/my_theme_style.dart';
import 'package:my_theme_style/my_theme_style_platform_interface.dart';
import 'package:my_theme_style/my_theme_style_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyThemeStylePlatform
    with MockPlatformInterfaceMixin
    implements MyThemeStylePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyThemeStylePlatform initialPlatform = MyThemeStylePlatform.instance;

  test('$MethodChannelMyThemeStyle is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyThemeStyle>());
  });

  test('getPlatformVersion', () async {
    MyThemeStyle myThemeStylePlugin = MyThemeStyle();
    MockMyThemeStylePlatform fakePlatform = MockMyThemeStylePlatform();
    MyThemeStylePlatform.instance = fakePlatform;

    expect(await myThemeStylePlugin.getPlatformVersion(), '42');
  });
}
