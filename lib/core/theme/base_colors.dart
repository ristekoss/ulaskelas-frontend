part of '_theme.dart';

class HoumiColors {
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

  ///CORE NORMAL THEME
  static const Color houmiPrimary = Color(0xFF303D83);
  static const Color houmiSecondary = Color(0xFF808CC9);
  static const Color houmiAccent = Color(0xFFC8D0FB);

  ///DERIVE COLOR
  static const Color transparent = Colors.transparent;
  static const Color disableColor = black40;
  static const Color border = black40;
  static Color shadowColor = black40.withOpacity(.2);

  ///BLACK
  static const Color black100 = Color(0xFF131313);
  static const Color black80 = Color(0xFF525252);
  static const Color black60 = Color(0xFF8A8A8A);
  static const Color black40 = Color(0xFFBBBBBB);

  ///WHITE
  static const Color neutralWhite = Color(0xFFF6F6F6);
  static const Color white = Color(0xFFFFFFFF);

  ///STATES
  static const Color positive = Color(0xFF37924B);
  static const Color positive5 = Color(0xFF8EBB98);
  static const Color negative = Color(0xFF923737);
}
