import 'package:flex_color_scheme/flex_color_scheme.dart';

abstract final class Themes {
  static final lightTheme = FlexThemeData.light(
    scheme: FlexScheme.damask,
    useMaterial3: true,
    fontFamily: 'Montserrat',
  );
  static final darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.damask,
    useMaterial3: true,
    fontFamily: 'Montserrat',
  );
}
