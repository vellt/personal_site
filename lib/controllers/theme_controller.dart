import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:personal_site/storage/theme_storage.dart';

class ThemeController extends GetxController {
  Themes currentTheme = Themes.light;
  final _themeStore = ThemeStore();
  void switchTheme() {
    Themes theme = (currentTheme == Themes.light ? Themes.dark : Themes.light);
    _themeStore.setCurrentTheme(theme);
    currentTheme = _themeStore.getCurrentTheme();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    currentTheme = _themeStore.getCurrentTheme();
    update();
  }

  Color _colors({required Color light, required Color dark}) {
    return (currentTheme == Themes.light) ? light : dark;
  }

  Color get background => _colors(
        light: Colors.white,
        dark: Colors.black,
      );

  Color get color => _colors(
        light: Colors.white,
        dark: Colors.black,
      );

  Color get mainButton => _colors(
        light: Colors.white,
        dark: Colors.black,
      );
}
