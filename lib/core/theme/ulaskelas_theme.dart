part of '_theme.dart';

class HoumiThemeImpl implements HoumiTheme {
  ThemeData _baseThemeData() {
    return ThemeData(
      brightness: Brightness.light,
    );
  }

  @override
  ThemeData normalTheme() {
    return _baseThemeData().copyWith(
      primaryColor: HoumiColors.houmiPrimary,
      secondaryHeaderColor: HoumiColors.houmiSecondary,
      accentColor: HoumiColors.houmiAccent,
      colorScheme: const ColorScheme(
        primary: HoumiColors.houmiPrimary,
        primaryVariant: HoumiColors.houmiPrimary,
        secondary: HoumiColors.houmiSecondary,
        secondaryVariant: HoumiColors.houmiSecondary,
        surface: HoumiColors.neutralWhite,
        background: HoumiColors.neutralWhite,
        error: HoumiColors.negative,
        onPrimary: HoumiColors.houmiPrimary,
        onSecondary: HoumiColors.houmiSecondary,
        onSurface: HoumiColors.neutralWhite,
        onBackground: HoumiColors.neutralWhite,
        onError: HoumiColors.negative,
        brightness: Brightness.light,
      ),
    );
  }

  @override
  ThemeData darkTheme() {
    return _baseThemeData().copyWith(
      primaryColor: HoumiColors.houmiPrimary,
      secondaryHeaderColor: HoumiColors.houmiSecondary,
      accentColor: HoumiColors.houmiAccent,
    );
  }

  @override
  ThemeData mapTheme(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.dark:
        return darkTheme();
      case ThemeType.normal:
        return normalTheme();
      default:
        return normalTheme();
    }
  }
}
