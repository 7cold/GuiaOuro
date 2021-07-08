import 'package:flutter/material.dart';

const String fontBold = "bold";
const String fontRegular = "regular";
const String fontLight = "light";

TextStyle textBold(double size, int color) => TextStyle(
      fontFamily: fontBold,
      color: Color(color),
      fontSize: size,
    );

TextStyle textRegular(double size, int color) => TextStyle(
      fontFamily: fontRegular,
      color: Color(color),
      fontSize: size,
    );

TextStyle textLight(double size, int color) => TextStyle(
      fontFamily: fontLight,
      color: Color(color),
      fontSize: size,
    );
