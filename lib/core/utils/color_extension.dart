// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/core/utils
// *******************************

import 'package:flutter/material.dart';

extension ColorEx on String{
  Color toColor(){
    var hexStringColor = this;
    final buffer = StringBuffer();

    if (hexStringColor.length == 6 || hexStringColor.length == 7) {
      buffer.write('ff');
      buffer.write(hexStringColor.replaceFirst("#", ""));
      return Color(int.parse(buffer.toString(), radix: 16));
    }else{
      return const Color(0xFFFFFFFF);
    }
  }
}