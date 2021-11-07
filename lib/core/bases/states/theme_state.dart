// Created by Muhamad Fauzi Ridwan on 7/17/21.

part of '_states.dart';

class ThemeState {
  ThemeState({ThemeData? themeData}) {
    if (themeData != null) {
      type = themeData;
      primaryColor = type!.primaryColor;
      secondaryColor = type!.secondaryHeaderColor;
      accentColor = type!.accentColor;
    }
  }

  static const String themeKey = 'theme';
  UlaskelasTheme theme = UlaskelasThemeImpl();
  ThemeData? type;
  Color? primaryColor;
  Color? secondaryColor;
  Color? accentColor;

  void init() {
    final themeType = _mapStringToThemeType(Pref.getString(themeKey));
    type = theme.mapTheme(themeType);
    primaryColor = type?.primaryColor;
    secondaryColor = type?.secondaryHeaderColor;
    accentColor = type?.accentColor;
  }

  void changeTheme(ThemeType themeType) {
    Pref.saveString(themeKey, _mapThemeTypeToString(themeType));
    type = theme.mapTheme(themeType);
    primaryColor = type?.primaryColor;
  }

  ThemeType _mapStringToThemeType(String? type) {
    if (type == 'darkTheme') {
      Logger().i('assign Normal Theme');
      return ThemeType.dark;
    } else {
      return ThemeType.normal;
    }
  }

  String _mapThemeTypeToString(ThemeType type) {
    switch (type) {
      case ThemeType.dark:
        return 'darkTheme';
      case ThemeType.normal:
        return 'normalTheme';
    }
  }
}
