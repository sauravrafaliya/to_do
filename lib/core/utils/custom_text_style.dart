// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/core/utils
// *******************************

import 'package:flutter/material.dart';
import 'package:to_do/core/theme/primary_theme.dart';

class CustomTextStyle{

  static TextStyle get black14_600 => _getCustomTextStyle("black_16_400");

  static TextStyle get red14_600 => _getCustomTextStyle("red_14_600");
  static TextStyle get red14_600o4 => _getCustomTextStyle("red_14_600_o4");

  static TextStyle get none14_600o4 => _getCustomTextStyle("none_16_400_o4");
  static TextStyle get none12_400 => _getCustomTextStyle("none_12_400");
  static TextStyle get none16_400 => _getCustomTextStyle("none_16_400");
  static TextStyle get none14_400 => _getCustomTextStyle("none_14_400");
  static TextStyle get none14_500 => _getCustomTextStyle("none_14_500");
  static TextStyle get none16_600 => _getCustomTextStyle("none_16_600");
  static TextStyle get none16_400o4 => _getCustomTextStyle("none_16_400_o4");
  static TextStyle get none30_700 => _getCustomTextStyle("none_30_700");
  static TextStyle get none32_700 => _getCustomTextStyle("none_32_700");
  static TextStyle get none40_700 => _getCustomTextStyle("none_40_700");

  static TextStyle get white14_400 => _getCustomTextStyle("white_16_400");

  static TextStyle get grey12_400 => _getCustomTextStyle("grey_12_400");


  static TextStyle _getCustomTextStyle(String styleName) {
    // Split the styleName into parts (e.g., "black_14_600" becomes ["black", "14", "600"])
    List<String> parts = styleName.split('_');

    // Default values
    Color? color;
    FontWeight fontWeight = FontWeight.normal;
    double fontSize = 14;
    double opacity = 1;

    // Check and set values based on parts
    if (parts.isNotEmpty) {
      switch (parts[0]) {
        case 'red':
          color = Colors.red;
          break;
        case 'white':
          color = Colors.white;
          break;
        case 'black':
          color = Colors.black;
          break;
        case 'grey':
          color = AppTheme.borderColor;
          break;
        case 'none':
        default:
          break;
      }
    }

    if (parts.length >= 2) {
      fontSize = double.tryParse(parts[1]) ?? 14;
    }

    if (parts.length >= 3) {
      switch (parts[2]) {
        case '100':
          fontWeight = FontWeight.w100;
          break;
        case '200':
          fontWeight = FontWeight.w200;
          break;
        case '300':
          fontWeight = FontWeight.w300;
          break;
        case '400':
          fontWeight = FontWeight.w400;
          break;
        case '500':
          fontWeight = FontWeight.w500;
          break;
        case '600':
          fontWeight = FontWeight.w600;
          break;
        case '700':
          fontWeight = FontWeight.w700;
          break;
        case '800':
          fontWeight = FontWeight.w800;
          break;
        case '900':
          fontWeight = FontWeight.w900;
          break;
        default:
          fontWeight = FontWeight.normal;
          break;
      }
    }

    if (parts.length >= 4) {
      if(parts[3].contains("o")){
        opacity = (double.tryParse(parts[3].substring(1))??1)/10;
      }
    }

    // Create and return the TextStyle
    return TextStyle(
      color: color?.withOpacity(opacity),
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }


}