import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeStore {
  final _box = GetStorage();
  final _boxName = "theme";

  Themes getCurrentTheme() {
    String readTheme = _box.read(_boxName) ?? "light";
    return Themes.values.byName(readTheme);
  }

  void setCurrentTheme(Themes theme) async {
    await _box.write(_boxName, theme.name);
    print(theme.name);
  }
}

enum Themes {
  light,
  dark,
}
