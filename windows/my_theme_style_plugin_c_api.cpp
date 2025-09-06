#include "include/my_theme_style/my_theme_style_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "my_theme_style_plugin.h"

void MyThemeStylePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  my_theme_style::MyThemeStylePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
