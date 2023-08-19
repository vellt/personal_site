import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_site/storage/theme_storage.dart';

class ThemeController extends GetxController {
  Themes currentTheme = Themes.light;
  final _themeStore = ThemeStore();

  @override
  void onInit() {
    super.onInit();
    currentTheme = _themeStore.getCurrentTheme();
    update();
  }

  void switchTheme() {
    bool condition = currentTheme == Themes.light;
    Themes theme = condition ? Themes.dark : Themes.light;
    Get.changeTheme(condition ? ThemeData.dark() : ThemeData.light());
    _themeStore.setCurrentTheme(theme);
    currentTheme = _themeStore.getCurrentTheme();
    update();
  }

  Color _colors({required Color light, required Color dark}) {
    return currentTheme == Themes.light ? light : dark;
  }

  Color get mainBackground => _colors(
        light: Colors.white,
        dark: Color(0xFF121212),
      );

  Color get upperDividerColor => _colors(
        light: Colors.black12,
        dark: Color.fromARGB(151, 37, 37, 37),
      );

  Color get bottomDividerColor => _colors(
        light: Color.fromARGB(187, 242, 242, 242),
        dark: Color(0xFF1C1C1C),
      );

  Color get botMessageBoxBackground => _colors(
        light: Color(0xFFF4F4F4),
        dark: Color(0xFF242424),
      );

  Color get clientMessageBoxBackground => _colors(
        light: Colors.blue,
        dark: Colors.blue,
      );

  Color get botMessageBoxFontColor => _colors(
        light: Colors.black,
        dark: Colors.white,
      );

  Color get clientMessageBoxFontColor => _colors(
        light: Colors.white,
        dark: Colors.white,
      );

  Color get onlineSignalColor => _colors(
        light: Colors.green,
        dark: Colors.green,
      );

  Color get iconColor => _colors(
        light: Colors.black,
        dark: Colors.white,
      );

  Color get mainTitleColor => _colors(
        light: Colors.black,
        dark: Colors.white,
      );

  Color get subTitleColor => _colors(
        light: Color.fromARGB(255, 207, 207, 207),
        dark: Color(0xFF4D4D4D),
      );

  Color get textInputFieldBackground => _colors(
        light: Color.fromARGB(217, 249, 249, 249),
        dark: Color(0xFF1D1D1D),
      );

  Color get textInputFieldHintColor => _colors(
        light: Color.fromARGB(255, 144, 144, 144),
        dark: Color.fromARGB(255, 144, 144, 144),
      );
}
