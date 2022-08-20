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
  static const Color danger = Color(0xFFE53A34);

  // Neutral Colors
  static const Color neutral100 = Color(0xFF1F262C);
  static const Color neutral90 = Color(0xFF50555B);
  static const Color neutral80 = Color(0xFF6E7377);
  static const Color neutral70 = Color(0xFF818589);
  static const Color neutral60 = Color(0xFFA6A9AC);
  static const Color neutral50 = Color(0xFFC7C9CA);
  static const Color neutral40 = Color(0xFFE3E4E5);
  static const Color neutral30 = Color(0xFFEFEFF0);
  static const Color neutral20 = Color(0xFFF6F6F6);
  static const Color neutral10 = Color(0xFFFFFFFF);

  // Gold Colors
  static const Color gold1 = Color(0xFFFFD668);
  static const Color gold2 = Color(0xFFDDA200);
  static const Color gold3 = Color(0xFFFFC62D);

  // Silver Colors
  static const Color silver1 = Color(0xFFC7C6C4);
  static const Color silver2 = Color(0xFF7D7D7D);
  static const Color silver3 = Color(0xFFB4B4B4);

  // Bronze Colors
  static const Color bronze1 = Color(0xFFCD7F32);
  static const Color bronze2 = Color(0xFFAE5906);
  static const Color bronze3 = Color(0xFFA15810);
}
