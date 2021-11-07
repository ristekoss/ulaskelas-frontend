part of '_theme.dart';

class BaseColors {
  static final themeState = GlobalState.theme().state;

  ///primary color base on theme
  static Color? primaryColor = themeState.primaryColor;
  static Color? secondaryColor = themeState.secondaryColor;
  static Color? accentColor = themeState.primaryColor;
  static MaterialColor primary = MaterialColor(
    primaryColor!.value,
    <int, Color>{
      50: primaryColor!,
      100: primaryColor!,
      200: primaryColor!,
      300: primaryColor!,
      400: primaryColor!,
      500: primaryColor!,
      600: primaryColor!,
      700: primaryColor!,
      800: primaryColor!,
      900: primaryColor!,
    },
  );

  /// Primary Color
  static const Color white = Color(0xFFFFFFFF);
  static const Color alabaster = Color(0xFFF8F8F8);
  static const Color purpleHearth = Color(0xFF5038BC);
  static const Color malibu = Color(0xFF64E6FB);

  /// Secondary Color
  static const Color mineShaft = Color(0xFF333333);
  static const Color cerise = Color(0xFFC424A3);
  static const Color goldenrod = Color(0xFFFFD668);

  /// State Color
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF7B500);
  static const Color error = Color(0xFFEB5757);

  /// Grey Color
  static const Color gray1 = Color(0xFF4F4F4F);
  static const Color gray2 = Color(0xFF828282);
  static const Color gray3 = Color(0xFFBDBDBD);
  static const Color gray4 = Color(0xFFE0E0E0);
  static const Color gray5 = Color(0xFFF2F2F2);
  static const Color transparent = Colors.transparent;
}
