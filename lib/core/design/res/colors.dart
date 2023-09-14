import 'package:flutter/material.dart';

const primaryColor = Color(0xff4c8613);
const secondaryColorText=Color(0xff707070);
MaterialColor getMaterialColor(int hex) {
  Color color = Color(hex);
  return MaterialColor(hex, {
    50: color.withOpacity(.1),
    100: color.withOpacity(.2),
    200: color.withOpacity(.3),
    300: color.withOpacity(.4),
    400: color.withOpacity(.5),
    500: color.withOpacity(.6),
    600: color.withOpacity(.7),
    700: color.withOpacity(.8),
    800: color.withOpacity(.9),
    900: color.withOpacity(1),
  });
}
