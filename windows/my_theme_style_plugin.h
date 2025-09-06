#ifndef FLUTTER_PLUGIN_MY_THEME_STYLE_PLUGIN_H_
#define FLUTTER_PLUGIN_MY_THEME_STYLE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace my_theme_style {

class MyThemeStylePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MyThemeStylePlugin();

  virtual ~MyThemeStylePlugin();

  // Disallow copy and assign.
  MyThemeStylePlugin(const MyThemeStylePlugin&) = delete;
  MyThemeStylePlugin& operator=(const MyThemeStylePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace my_theme_style

#endif  // FLUTTER_PLUGIN_MY_THEME_STYLE_PLUGIN_H_
